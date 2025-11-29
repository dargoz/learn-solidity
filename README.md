## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
## learn-solidity — Foundry + TypeScript helper

This repository is a small learning playground for Solidity using Foundry. It includes a TypeScript helper script that exports ABIs produced by Foundry into a frontend-friendly `frontend/src/abis` directory.

Quickstart
1. Ensure you have the prerequisites installed: Node (with pnpm), and Foundry (forge/anvil). The `init.sh` script will check for these and print install hints if missing.
2. From the project root run the initializer (one-time):

```bash
./init.sh
```

What `./init.sh` does
- Checks for `pnpm` and `forge` (Foundry).
- Runs `pnpm install` to install Node dev dependencies.
- Runs `pnpm run build`, which executes the TypeScript ABI exporter and then `forge build`.

Useful commands
- Install dependencies manually: `pnpm install`
- Export ABIs only: `pnpm run export-abis`
- Full build (export ABIs + compile): `pnpm run build`
- Run solidity tests: `forge test`

Notes for TypeScript scripts
- The repo includes a small TypeScript script at `script/export-abis.ts` that imports Node built-ins like `fs` and `path`. If you see TypeScript errors about missing Node types, ensure `@types/node` is installed as a dev dependency and `tsconfig.json` includes `"types": ["node"]`.

Where ABIs are written
- The export script writes TypeScript ABI files to `frontend/src/abis/<ContractName>Abi.ts`.

.gitignore
- The repository contains a `.gitignore` that excludes `node_modules`, TypeScript `dist/`, Foundry `out/` and `cache/`, environment files, editor folders, and other common temp files.

Foundry reference

Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

Documentation: https://book.getfoundry.sh/

Common Foundry commands

```sh
forge build      # compile contracts
forge test       # run tests
forge fmt        # format solidity code
anvil            # run local node
cast <subcommand>
```

## Deploy Smart Contract
command:
```sh
forge script <DeployFileScript> --broadcast --slow
```
example:
```sh
forge script Counter --broadcast --slow
```

## Verify Deployed smart Contract:
```sh
forge verify-contract \
  --chain-id 11155111 \ # Sepolia Chain ID
  <DEPLOYED_CONTRACT_ADDRESS> \
  src/YourContract.sol:YourContract \
  $ETHERSCAN_API_KEY
```