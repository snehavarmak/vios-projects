# README

This repository contains three smart contracts for decentralized applications: **Land Registry**, **Bank Application**, and **Health Records**. These contracts provide basic functionality for land ownership management, banking operations, and health record management on the blockchain.

---

## Table of Contents

- [Land Registry](#land-registry)
- [Bank Application](#bank-application)
- [Health Records](#health-records)
- [Deployment Instructions](#deployment-instructions)
- [Testing](#testing)
---

## Land Registry

### Overview

The **Land Registry** contract allows users to register land, transfer ownership, and check the status of land ownership.

### Features

- **Register Land**: Users can register land by providing an ID, location, and area.
- **Transfer Ownership**: The current owner of the land can transfer ownership to another address.
- **Get Land Details**: View the details of a land, including ID, location, area, owner, and registration status.
- **Check Registration Status**: Check whether a land is registered.

### Functions

- `registerLand(uint256 _id, string memory _location, uint256 _area)`: Register a new land.
- `transferOwner(uint256 _id, address _newOwner)`: Transfer ownership of a registered land.
- `getLand(uint256 _id)`: Get the details of a registered land.
- `isLandRegistered(uint256 _id)`: Check if a land is registered.

---

## Bank Application

### Overview

The **Bank Application** contract implements a simple banking system where users can create accounts, deposit and withdraw funds, and transfer money between accounts.

### Features

- **Create Account**: Users can create an account in the bank.
- **Deposit**: Users can deposit funds into their account.
- **Withdraw**: Users can withdraw funds from their account.
- **Transfer**: Users can transfer funds to other bank accounts.
- **Get Balance**: Users can check their account balance.

### Functions

- `createAccount()`: Create a new bank account.
- `deposit()`: Deposit funds into the user's account.
- `withdrawal(uint256 amount)`: Withdraw specified amount from the user's account.
- `transfer(address to, uint256 amount)`: Transfer funds to another user's account.
- `getBalance()`: Get the user's account balance.

---

## Health Records

### Overview

The **Health Records** contract allows users to manage medical records, where records can be added, updated, and shared with authorized users.

### Features

- **Add Record**: Add a new medical record.
- **Update Record**: Update an existing medical record.
- **Grant Access**: Grant access to a specific user for a record.
- **Revoke Access**: Revoke access to a specific user for a record.
- **View Record**: View the content of a medical record if authorized.

### Functions

- `addRecord(uint recordId, string memory data)`: Add a new record.
- `updateRecord(uint recordId, string memory data)`: Update an existing record.
- `getRecord(uint recordId)`: View the details of a record.
- `grantAccess(uint recordId, address user)`: Grant access to a user for a specific record.
- `revokeAccess(uint recordId, address user)`: Revoke access from a user for a specific record.

---

## Deployment Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/snehavarmak/vios-projects
   cd vios-projects
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Compile the smart contracts:
   ```bash
   npx hardhat compile
   ```

4. Deploy the contracts to your chosen network (e.g., Sepolia, Rinkeby):
   ```bash
   npx hardhat run scripts/deploy.js --network sepolia
   ```

5. Interact with the contracts via Hardhat console or integrate them into your front-end application.

---

## Testing

To test the contracts, you can use the Hardhat testing framework:

1. Run the tests:
   ```bash
   npx hardhat test
   ```

2. Ensure that the tests cover all functions and edge cases for each contract.

---

## License

This project is licensed under the MIT License.

---
