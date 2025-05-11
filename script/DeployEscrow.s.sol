// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Escrow.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployEscrow is Script {
    function run() external {
        // Load environment variables
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address seller = vm.envAddress("SELLER_ADDRESS");
        address tokenAddress = vm.envAddress("TOKEN_ADDRESS");
        uint256 amount = vm.envUint("ESCROW_AMOUNT");

        // Start broadcasting transactions
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the contract
        Escrow escrow = new Escrow(seller, IERC20(tokenAddress), amount);

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("Escrow deployed at:", address(escrow));
    }
}
