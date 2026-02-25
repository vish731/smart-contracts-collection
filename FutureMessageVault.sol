// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FutureMessageVault {
    struct FutureMsg {
        string text;
        uint256 unlockTime;
    }

    mapping(address => FutureMsg[]) public vault;

    function store(string calldata text, uint256 delaySec) external {
        vault[msg.sender].push(
            FutureMsg(text, block.timestamp + delaySec)
        );
    }

    function read(uint256 index) external view returns (string memory) {
        FutureMsg memory m = vault[msg.sender][index];
        require(block.timestamp >= m.unlockTime, "Too early");
        return m.text;
    }
}
