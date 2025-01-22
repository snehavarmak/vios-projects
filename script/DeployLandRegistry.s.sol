// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/LandRegistry.sol";

contract DeployLandRegistry is Script {
    function run() external {
        // Load the deployer's private key from the environment
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        // Start broadcasting transactions with the deployer's private key
        vm.startBroadcast(deployerPrivateKey);

        // For Anvil Skip the Above Code

        // Deploy the LandRegistry contract
        LandRegistry landRegistry = new LandRegistry();

        // Log the address of the deployed contract
        console.log("LandRegistry deployed at:", address(landRegistry));

        // Stop broadcasting transactions
        vm.stopBroadcast();
    }
}
