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

}
