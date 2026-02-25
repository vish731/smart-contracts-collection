// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OneTimeNote {
    mapping(address => string) public notes;

    function writeOnce(string calldata _note) external {
        require(bytes(notes[msg.sender]).length == 0, "Already written");
        notes[msg.sender] = _note;
    }
}
