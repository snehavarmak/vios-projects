// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/LandRegistry.sol";

contract LandRegistryTest is Test {
    LandRegistry public landRegistry;

    address public owner = address(0x123);
    address public newOwner = address(0x456);

    function setUp() public {
        // Deploy the LandRegistry contract before each test
        landRegistry = new LandRegistry();
    }

    function testRegisterLand() public {
        // Act as the owner
        vm.prank(owner);

        // Register a land
        uint256 landId = 1;
        string memory location = "Sydney, Australia";
        uint256 area = 500;

        landRegistry.registerLand(landId, location, area);

        // Verify the land is registered
        (
            uint256 id,
            string memory returnedLocation,
            uint256 returnedArea,
            address returnedOwner,
            bool registered
        ) = landRegistry.getLand(landId);

        assertEq(id, landId);
        assertEq(returnedLocation, location);
        assertEq(returnedArea, area);
        assertEq(returnedOwner, owner);
        assertTrue(registered);
    }

    function testCannotRegisterAlreadyRegisteredLand() public {
        vm.prank(owner);
        landRegistry.registerLand(1, "Sydney", 500);

        // Attempt to register the same land again
        vm.expectRevert("Land already registered");
        vm.prank(owner);
        landRegistry.registerLand(1, "Sydney", 500);
    }

    function testTransferOwnership() public {
        // Register a land
        vm.prank(owner);
        landRegistry.registerLand(1, "Sydney", 500);

        // Transfer ownership
        vm.prank(owner);
        landRegistry.transferOwner(1, newOwner);

        // Verify the new owner
        (, , , address returnedOwner, ) = landRegistry.getLand(1);
        assertEq(returnedOwner, newOwner);
    }

    function testCannotTransferOwnershipIfNotOwner() public {
        // Register a land
        vm.prank(owner);
        landRegistry.registerLand(1, "Sydney", 500);

        // Attempt to transfer ownership from a non-owner address
        vm.prank(newOwner);
        vm.expectRevert("Only the owner can transfer ownership");
        landRegistry.transferOwner(1, newOwner);
    }

    function testCannotTransferOwnershipToZeroAddress() public {
        // Register a land
        vm.prank(owner);
        landRegistry.registerLand(1, "Sydney", 500);

        // Attempt to transfer ownership to address(0)
        vm.prank(owner);
        vm.expectRevert("Invalid address");
        landRegistry.transferOwner(1, address(0));
    }

    function testIsLandRegistered() public {
        // Register a land
        vm.prank(owner);
        landRegistry.registerLand(1, "Sydney", 500);

        // Verify the land is registered
        assertTrue(landRegistry.isLandRegistered(1));

        // Verify a non-registered land
        assertFalse(landRegistry.isLandRegistered(2));
    }
}
