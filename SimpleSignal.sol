// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleSignal {
    mapping(address => bool) public flagged;

    event Signaled(address indexed user);

    function signal() external {
        require(!flagged[msg.sender], "already");
        flagged[msg.sender] = true;
        emit Signaled(msg.sender);
    }
}
