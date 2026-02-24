// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BlockGreeter {
    string public greeting = "gm Base";

    function setGreeting(string calldata _g) external {
        greeting = _g;
    }
}
