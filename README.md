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

## Deployment

Deploy smart contracts to blockchain networks using Forge's scripting capabilities.

### Prerequisites

Before deploying, ensure you have:
- A valid RPC endpoint (e.g., from Infura, Alchemy, or QuickNode)
- A private key or mnemonic with sufficient funds for gas
- (Optional) An Etherscan API key for contract verification

### Environment Setup

Create a `.env` file in the project root with your credentials:

```sh
# .env
RPC_URL=https://sepolia.infura.io/v3/YOUR_INFURA_KEY
DEPLOYER_PRIVATE_KEY=0x<your_private_key>
ETHERSCAN_API_KEY=<your_etherscan_key>
```

**Important**: Never commit `.env` to version control. It's already in `.gitignore`.

Load these variables before running deployment scripts:

```sh
source .env
```

### Deploy to a Testnet

Deploy a contract to Sepolia (or another testnet) using the deployment script:

```sh
forge script script/Counter.s.sol:CounterScript \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --slow
```

**Flags explained**:
- `--broadcast` — actually sends the transaction (without it, only simulates)
- `--slow` — waits for transaction confirmation before continuing
- `--rpc-url` — the network RPC endpoint
- `--private-key` — the account private key (use env var for security)

### Verify Contract on Etherscan (Optional)

After deployment, verify your contract code on Etherscan for transparency:

```sh
forge verify-contract \
  --chain-id 11155111 \
  <DEPLOYED_CONTRACT_ADDRESS> \
  src/Counter.sol:Counter \
  --etherscan-api-key $ETHERSCAN_API_KEY
```

**Chain IDs**:
- Sepolia: `11155111`
- Ethereum Mainnet: `1`
- Polygon: `137`
- Arbitrum: `42161`

Replace `<DEPLOYED_CONTRACT_ADDRESS>` with your contract's address from the deployment output.

### Example: Full Deployment Flow

1. Load environment variables
    ```sh
    source .env
    ```
2. Deploy to Sepolia
    ```sh
    forge script script/Counter.s.sol:CounterScript \
    --broadcast \
    --slow
    ```
3. Verify on Etherscan (optional, after a few block confirmations)
    ```sh
    forge verify-contract \
    --chain-id 11155111 \
    0xYourDeployedAddress \
    src/Counter.sol:Counter \
    --etherscan-api-key $ETHERSCAN_API_KEY
    ```

### Useful Resources

- [Foundry Deployment Docs](https://book.getfoundry.sh/forge/deploying)
- [Etherscan API Documentation](https://docs.etherscan.io/)
- [RPC Providers](https://ethereum.org/en/developers/docs/apis/json-rpc/)