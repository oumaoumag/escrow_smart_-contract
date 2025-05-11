# Escrow Smart Contract

A secure and efficient Ethereum-based escrow system for facilitating token transactions between buyers and sellers, with comprehensive testing including unit tests and fuzz testing.

## Overview

This project implements a secure escrow smart contract that facilitates token transactions between a buyer and seller. The contract holds ERC20 tokens in escrow until the buyer releases them to the seller, providing security for both parties in the transaction.

## Features

- **Secure Token Escrow**: Safely holds tokens between buyer and seller
- **Role-Based Access Control**: Only the buyer can deposit and release tokens
- **Withdrawal Protection**: Only the seller can withdraw tokens after release
- **Double Withdrawal Prevention**: Prevents multiple withdrawals of the same funds
- **Comprehensive Testing**: Includes unit tests and property-based fuzz testing

## Deployed Contract

- **Network**: Sepolia Testnet
- **Contract Address**: `0xD45b2EE7836Ebf4CFe33523232E4E5EEc051EAa1`
- **Transaction Hash**: [0x3f69404c4d3a0f98e095a575524cdb58a4a8aeceeca8e2c90ba24a7a8033a637](https://sepolia-blockscout.lisk.com/tx/0x3f69404c4d3a0f98e095a575524cdb58a4a8aeceeca8e2c90ba24a7a8033a637)

## Testing Approach

The contract includes two types of tests:

1. **Unit Tests**: Verify specific functionality like deposit, release, and withdrawal permissions
2. **Fuzz Testing**: Property-based tests that verify the contract behaves correctly with random inputs

The test suite uses mock ERC20 tokens to simulate real token behavior without requiring external dependencies.

## Development Tools

This project is built with [Foundry](https://getfoundry.sh/), a blazing fast, portable, and modular toolkit for Ethereum application development written in Rust.

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools)
- **Cast**: Swiss army knife for interacting with EVM smart contracts
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network
- **Chisel**: Fast, utilitarian, and verbose Solidity REPL

## Getting Started

### Prerequisites

- [Foundry](https://getfoundry.sh/) installed
- An Ethereum wallet with Sepolia ETH for deployment and testing

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/escrow-smart-contract.git
cd escrow-smart-contract

# Install dependencies
forge install
```

### Build

```bash
forge build
```

### Test

```bash
forge test
```

### Format

```bash
forge fmt
```

### Deploy

```bash
# Set up environment variables in .env file
cp .env.example .env
# Edit .env with your values

# Deploy the contract
forge script script/DeployEscrow.s.sol --rpc-url $RPC_URL --private-key $PRIVATE_KEY --broadcast
```

### Interact with the Contract

To interact with the deployed contract, you can use Cast:

```bash
# Deposit tokens (as buyer)
cast send $ESCROW_ADDRESS "deposit()" --rpc-url $RPC_URL --private-key $BUYER_PRIVATE_KEY

# Release tokens (as buyer)
cast send $ESCROW_ADDRESS "release()" --rpc-url $RPC_URL --private-key $BUYER_PRIVATE_KEY

# Withdraw tokens (as seller)
cast send $ESCROW_ADDRESS "withdraw()" --rpc-url $RPC_URL --private-key $SELLER_PRIVATE_KEY
```

## Documentation

For more information about Foundry, visit the [Foundry Book](https://book.getfoundry.sh/).

## License

This project is licensed under the MIT License - see the LICENSE file for details.
