// SPDX-License-Identifier: GPL-0.3
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Escrow.sol";

// mock ERC20 token for testing
contract MockERC20 {
     mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

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

}
