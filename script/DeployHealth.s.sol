// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/MyContract.sol";

contract DeployScript is Script {
    function run() external {
        vm.startBroadcast();

        // Deploy the contract
        MyContract myContract = new MyContract();

        console.log("MyContract deployed at:", address(myContract));

        vm.stopBroadcast();
    }
}
