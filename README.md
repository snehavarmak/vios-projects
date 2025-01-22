# LandRegistry Smart Contract

A simple smart contract for land registration and ownership transfer. This contract allows users to register land, transfer ownership, and query land details.

## Features

- **Land Registration:** Users can register a land with an ID, location, and area.
- **Ownership Transfer:** Owners can transfer land ownership to another address.
- **Land Details:** Retrieve land details by land ID, including location, area, and owner.
- **Land Registration Check:** Check if a land is registered.

## Prerequisites

Ensure you have the following installed:

- [Foundry](https://github.com/foundry-rs/foundry) (includes Anvil and Forge) for smart contract deployment and testing
- Solidity v0.8.0 (or higher)

## Project Setup

Clone the repository and install the dependencies:

```bash
git clone <repository-url>
cd <project-directory>
forge init
```

### Smart Contract

The `LandRegistry` smart contract is written in Solidity and located in the `src` directory. The contract allows users to register land, transfer ownership, and query land details.

### Deployment Script

The contract is deployed using a deployment script in the `script` directory. To deploy the contract, you can use the provided `DeployLandRegistry.s.sol` script.

### Test Script

The test script for the contract is located in the `test` directory. It uses the Foundry testing framework to verify the contract functionality. Example tests include registering land and transferring ownership.

### Running the Anvil Blockchain

Start the Anvil local blockchain in one terminal:

```bash
anvil
```

### Deploying the Contract

Once the Anvil blockchain is running, deploy the contract using the `forge` command:

```bash
forge script script/DeployLandRegistry.s.sol --fork-url http://127.0.0.1:8545 --broadcast
```

This will deploy the `LandRegistry` contract to the local Anvil blockchain.

### Testing the Contract

To test the contract functions (such as registration and ownership transfer), run the following command:

```bash
forge test
```

This will execute the tests and verify that the contract behaves as expected.

## Contract Functions

### `registerLand(uint256 _id, string memory _location, uint256 _area)`

Registers a new land with the provided ID, location, and area.

- **Parameters:**
  - `_id`: The ID of the land
  - `_location`: The location of the land
  - `_area`: The area of the land

### `transferOwner(uint256 _id, address _newOwner)`

Transfers ownership of a registered land to a new owner.

- **Parameters:**
  - `_id`: The ID of the land
  - `_newOwner`: The address of the new owner

### `getLand(uint256 _id)`

Returns the details of a registered land.

- **Parameters:**
  - `_id`: The ID of the land

- **Returns:**
  - The land’s ID, location, area, owner, and registration status

### `isLandRegistered(uint256 _id)`

Checks if a land is registered.

- **Parameters:**
  - `_id`: The ID of the land

- **Returns:**
  - `true` if the land is registered, `false` otherwise

---