// SPDX-License-Identifier: GPL-0.3
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Escrow {
    // State variables
    address public buyer;   
    address public seller;  
    IERC20 public token;    // The IERC20 token in escrow
    uint256 public amount;  // Amount of tokens in escrow
    bool public isReleased; 

    // Sets up the contract with seller, token, and amount
    constructor(address _seller, IERC20 _token, uint256 _amount) {
        buyer = msg.sender;     // Buyer is the one deploying
        seller = _seller;
        token = _token;
        amount = _amount;
        isReleased = false;
    }

    // Allows buyer to deposit tokens into the contract
    function deposit() external {
        require(msg.sender == buyer, "Only buyer can deposit");
        token.transferFrom(buyer, address(this), amount);
    }

    // Allows Buyer to release the tokens
    function release() external {
        require(msg.sender == buyer, "Only buyer can release");
        isReleased = true;
    }

    // Allows seller to withdraw tokens after release
    function withdraw() external {
        require(msg.sender == seller, "Only seller can withdraww");
        require(isReleased, "Funds not released yet");
        token.transfer(seller, amount);
    }
}
