## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Escrow Smart Contract

This repository contains an Escrow smart contract that facilitates secure token transactions between a buyer and seller.

### Deployed Contract

- **Network**: Sepolia Testnet
- **Contract Address**: `0xD45b2EE7836Ebf4CFe33523232E4E5EEc051EAa1`
- **Transaction Hash**: [0x3f69404c4d3a0f98e095a575524cdb58a4a8aeceeca8e2c90ba24a7a8033a637](https://sepolia-blockscout.lisk.com/tx/0x3f69404c4d3a0f98e095a575524cdb58a4a8aeceeca8e2c90ba24a7a8033a637)

### Features

- Secure token escrow between buyer and seller
- Buyer can deposit tokens into the escrow
- Buyer can release tokens to the seller
- Seller can withdraw tokens after release
- Protection against double withdrawals

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Deploy

```shell
$ forge script script/DeployEscrow.s.sol --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast
```

### Interact with the Contract

To interact with the deployed contract, you can use Cast:

```shell
# Deposit tokens (as buyer)
$ cast send <escrow_address> "deposit()" --rpc-url <your_rpc_url> --private-key <your_private_key>

# Release tokens (as buyer)
$ cast send <escrow_address> "release()" --rpc-url <your_rpc_url> --private-key <your_private_key>

# Withdraw tokens (as seller)
$ cast send <escrow_address> "withdraw()" --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
