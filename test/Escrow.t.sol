// SPDX-License-Identifier: GPL-0.3
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Escrow.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// mock ERC20 token for testing
contract MockERC20 is IERC20 {
     mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    // Add these to implement IERC20 interface
    string public name = "Mock Token";
    string public symbol = "MOCK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    function transfer(address to, uint256 value) external returns (bool) {
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        allowance[from][msg.sender] -= value;
        balanceOf[from] -= value;
        balanceOf[to] += value;
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool) {
        allowance[msg.sender][spender] = value;
        return true;
    }

      function mint(address to, uint256 value) external {
        balanceOf[to] += value;
    }
}

contract EscrowTest is Test {
     MockERC20 public token;
    Escrow public escrow;
    address public buyer = address(1);  
    address public seller = address(2);
    uint256 public amount = 1000;       
   

    // Sets up a fresh contract before each test
    function setUp() public {
        token = new MockERC20();
        vm.prank(buyer);                
        escrow = new Escrow(seller, token, amount);
        token.mint(buyer, amount);      
        vm.prank(buyer);
        token.approve(address(escrow), amount); // Approve escrow to spend
    }

    function testOnlyBuyerCanDeposit() public {
        vm.prank(buyer);
        escrow.deposit();
        assertEq(token.balanceOf(address(escrow)), amount); 

        // Seller tries and fails
        vm.prank(seller);
        vm.expectRevert("Only buyer can deposit");
        escrow.deposit();
    }

    function testOnlyBuyerCanRelease() public {
        vm.prank(seller);
        vm.expectRevert("Only buyer can release");
        escrow.release();

        vm.prank(buyer);
        escrow.release();
        assertTrue(escrow.isReleased()); 
    }

    function testOnlySellerCanWithdrawAfterRelease() public {
        vm.prank(buyer);
        escrow.deposit();
        vm.prank(buyer);
        escrow.release();

        vm.prank(seller);
        escrow.withdraw();
        assertEq(token.balanceOf(seller), amount); 

        // Try withdrawing again (should fail if we add a check)
        vm.prank(seller);
        vm.expectRevert("Already withdrawn");
        escrow.withdraw(); 
    }

    // Fuzz test with random amounts
    function testFuzzEscrowFlow(uint256 fuzzAmount) public {
        vm.assume(fuzzAmount > 0 && fuzzAmount < type(uint256).max); // Limit range

        // Set up a new instance for fuzzing
        MockERC20 fuzzToken = new MockERC20();
        fuzzToken.mint(buyer, fuzzAmount);

        vm.prank(buyer);
        Escrow fuzzEscrow = new Escrow(seller, fuzzToken, fuzzAmount);

        vm.prank(buyer);
        fuzzToken.approve(address(fuzzEscrow), fuzzAmount);

        // Full flow
        vm.prank(buyer);
        fuzzEscrow.deposit();
        vm.prank(buyer);
        fuzzEscrow.release();
        vm.prank(seller);
        fuzzEscrow.withdraw();

        assertEq(fuzzToken.balanceOf(seller), fuzzAmount); // Seller got right amount
        assertEq(fuzzToken.balanceOf(address(fuzzEscrow)), 0); // Escrow empty
    }
}
