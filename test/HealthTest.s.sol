// --- Test Cases ---

import "forge-std/Test.sol";
import "../src/MyContract.sol";

contract MyContractTest is Test {
    MyContract private myContract;

    function setUp() public {
        myContract = new MyContract();
    }

    function testAddRecord() public {
        myContract.addRecord(1, "2025-01-01");

        (string memory date, address[] memory authorizedUsers) = myContract.getRecord(1);

        assertEq(date, "2025-01-01");
        assertEq(authorizedUsers.length, 0);
    }

    function testUpdateRecord() public {
        myContract.addRecord(1, "2025-01-01");
        myContract.updateRecord(1, "2025-01-02");

        (string memory date, ) = myContract.getRecord(1);

        assertEq(date, "2025-01-02");
    }

    function testGrantAccess() public {
        myContract.addRecord(1, "2025-01-01");
        myContract.grantAccess(1, address(0x123));

        (, address[] memory authorizedUsers) = myContract.getRecord(1);

        assertEq(authorizedUsers[0], address(0x123));
    }

    function testRevokeAccess() public {
        myContract.addRecord(1, "2025-01-01");
        myContract.grantAccess(1, address(0x123));
        myContract.revokeAccess(1, address(0x123));

        (, address[] memory authorizedUsers) = myContract.getRecord(1);

        assertEq(authorizedUsers.length, 0);
    }

    function testUnauthorizedAccess() public {
        myContract.addRecord(1, "2025-01-01");

        vm.prank(address(0x456));
        vm.expectRevert("You are not authorized to access this record");
        myContract.getRecord(1);
    }
}
