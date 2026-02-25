// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MoodOracle {
    enum Mood { SAD, OK, HAPPY }

    mapping(address => Mood) public moods;

    function setMood(Mood _m) external {
        moods[msg.sender] = _m;
    }
}
