// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CooldownCounter {
    mapping(address => uint256) public lastPing;
    uint256 public constant COOLDOWN = 60;

    event Ping(address indexed user, uint256 nextTime);

    function ping() external {
        require(block.timestamp >= lastPing[msg.sender] + COOLDOWN, "wait");

        lastPing[msg.sender] = block.timestamp;
        emit Ping(msg.sender, block.timestamp + COOLDOWN);
    }
}
