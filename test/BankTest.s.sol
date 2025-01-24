// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Bank.sol";

contract BankTest is Test {
    Bank private bank;

    address private user1 = address(0x123);
    address private user2 = address(0x456);

    function setUp() public {
        // Deploy a new instance of the Bank contract before each test
        bank = new Bank();
    }

    function testCreateAccount() public {
        vm.prank(user1); // Simulates user1 calling the function
        bank.createAccount();

        vm.prank(user2);
        bank.createAccount();

        // Verify accounts were created successfully
        vm.prank(user1);
        uint256 balanceUser1 = bank.getBalance();
        assertEq(balanceUser1, 0);

        vm.prank(user2);
        uint256 balanceUser2 = bank.getBalance();
        assertEq(balanceUser2, 0);
    }

    function testDeposit() public {
        vm.prank(user1);
        bank.createAccount();

        // Deposit funds
        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        // Verify deposit
        vm.prank(user1);
        uint256 balance = bank.getBalance();
        assertEq(balance, 1 ether);
    }

    function testWithdraw() public {
        vm.prank(user1);
        bank.createAccount();

        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        // Withdraw funds
        vm.prank(user1);
        bank.withdrawal(0.5 ether);

        // Verify updated balance
        vm.prank(user1);
        uint256 balance = bank.getBalance();
        assertEq(balance, 0.5 ether);
    }

    function testTransfer() public {
        vm.prank(user1);
        bank.createAccount();

        vm.prank(user2);
        bank.createAccount();

        vm.prank(user1);
        bank.deposit{value: 2 ether}();

        // Transfer funds
        vm.prank(user1);
        bank.transfer(user2, 1 ether);

        // Verify balances
        vm.prank(user1);
        uint256 balanceUser1 = bank.getBalance();
        assertEq(balanceUser1, 1 ether);

        vm.prank(user2);
        uint256 balanceUser2 = bank.getBalance();
        assertEq(balanceUser2, 1 ether);
    }

    function testFailCreateAccountTwice() public {
        vm.prank(user1);
        bank.createAccount();

        // Attempt to create the account again
        vm.prank(user1);
        bank.createAccount(); // Should revert
    }

    function testFailWithdrawMoreThanBalance() public {
        vm.prank(user1);
        bank.createAccount();

        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        // Attempt to withdraw more than the balance
        vm.prank(user1);
        bank.withdrawal(2 ether); // Should revert
    }

    function testFailTransferToNonExistentAccount() public {
        vm.prank(user1);
        bank.createAccount();

        vm.prank(user1);
        bank.deposit{value: 1 ether}();

        // Attempt to transfer to an address without an account
        vm.prank(user1);
        bank.transfer(address(0x999), 1 ether); // Should revert
    }
}
