// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LandRegistry {
    
    struct Land {
        uint256 id;
        string location;
        uint256 area;
        address owner;
        bool registered;
    }
    
    mapping(uint256 => Land) public lands;

    event LandRegistered(uint256 indexed landId, string location, uint256 area, address indexed owner);
    event OwnershipTransferred(uint256 indexed landId, address indexed oldOwner, address indexed newOwner);

    /// @notice Registers a new land
    /// @param _id The ID of the land
    /// @param _location The location of the land
    /// @param _area The area of the land
    function registerLand(uint256 _id, string memory _location, uint256 _area) public {
        require(!lands[_id].registered, "Land already registered");

        lands[_id] = Land({
            id: _id,
            location: _location,
            area: _area,
            owner: msg.sender,
            registered: true
        });

        emit LandRegistered(_id, _location, _area, msg.sender);
    }

    /// @notice Transfers ownership of a registered land
    /// @param _id The ID of the land
    /// @param _newOwner The address of the new owner
    function transferOwner(uint256 _id, address _newOwner) public {
        Land storage land = lands[_id];
        require(land.registered, "Land not registered");
        require(land.owner == msg.sender, "Only the owner can transfer ownership");
        require(_newOwner != address(0), "Invalid address");

        address oldOwner = land.owner;
        land.owner = _newOwner;

        emit OwnershipTransferred(_id, oldOwner, _newOwner);
    }

    /// @notice Gets details of a registered land
    /// @param _id The ID of the land
    /// @return id The ID of the land
    /// @return location The location of the land
    /// @return area The area of the land
    /// @return owner The owner's address
    /// @return registered Whether the land is registered
    function getLand(uint256 _id)
        public
        view
        returns (
            uint256 id,
            string memory location,
            uint256 area,
            address owner,
            bool registered
        )
    {
        Land storage land = lands[_id];
        require(land.registered, "Land not registered");

        return (land.id, land.location, land.area, land.owner, land.registered);
    }

    /// @notice Checks if a land is registered
    /// @param _id The ID of the land
    /// @return True if the land is registered, false otherwise
    function isLandRegistered(uint256 _id) public view returns (bool) {
        return lands[_id].registered;
    }
}
