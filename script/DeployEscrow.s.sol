// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Escrow.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployEscrow is Script {
    function run() external {
        
        // Load environment variables
        string memory privateKey = vm.envString("PRIVATE_KEY");
        address seller = address(0xYourSellerAddressHere);  
        IERC20 token = IERC20(0xYourTokenAddressHere);      
        uint256 amount = 1000;                             

        // Start broadcasting transactions
        vm.startBroadcast(privateKey);

        // Deploy the contract
        Escrow escrow = new Escrow(seller, token, amount);

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("Escrow deployed at:", address(escrow));
    }
}

    Replace 0xYourSellerAddressH