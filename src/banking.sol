// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    struct Account {
        uint256 balance;
        address owner;
    }

    mapping(address => Account) private accounts;
    address private bankOwner;

    event AccountCreated(address indexed owner);
    event Deposit(address indexed owner, uint256 amount);
    event Withdrawal(address indexed owner, uint256 amount);
    event Transfer(address indexed from, address indexed to, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == bankOwner, "Not the bank Owner");
        _;
    }

    modifier onlyAccountOwner() {
        require(accounts[msg.sender].owner == msg.sender, "Not the account owner");
        _;
    }

    constructor() {
        bankOwner = msg.sender; // Ensure the constructor doesn't call account-dependent logic
    }

    function createAccount() public {
        require(accounts[msg.sender].owner == address(0), "Account already exists");
        accounts[msg.sender] = Account({ balance: 0, owner: msg.sender });
        emit AccountCreated(msg.sender);
    }

    function deposit() public payable onlyAccountOwner {
        accounts[msg.sender].balance += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdrawal(uint256 amount) public onlyAccountOwner {
        require(accounts[msg.sender].balance >= amount, "Insufficient balance");
        accounts[msg.sender].balance -= amount; // Correct deduction
        payable(msg.sender).transfer(amount); // Correct transfer
        emit Withdrawal(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public onlyAccountOwner {
        require(accounts[to].owner != address(0), "Recipient account does not exist");
        require(accounts[msg.sender].balance >= amount, "Insufficient balance");

        accounts[msg.sender].balance -= amount; // Correct deduction
        accounts[to].balance += amount; // Correct addition
        emit Transfer(msg.sender, to, amount);
    }

    function getBalance() public view onlyAccountOwner returns (uint256) {
        return accounts[msg.sender].balance;
    }
}
