// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Bank.sol";

contract DeployBank is Script {
    function run() external {
        vm.startBroadcast();

        Bank bank = new Bank();

        console.log("Bank contract deployed at:", address(bank));

        vm.stopBroadcast();
    }
}
