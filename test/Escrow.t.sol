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