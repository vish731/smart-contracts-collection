// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract NicknameRegistry {
    mapping(bytes32 => address) public ownerOf;

    event Registered(bytes32 indexed name, address indexed user);

    function register(string calldata name) external {
        bytes32 key = keccak256(bytes(name));
        require(ownerOf[key] == address(0), "taken");

        ownerOf[key] = msg.sender;
        emit Registered(key, msg.sender);
    }
}
