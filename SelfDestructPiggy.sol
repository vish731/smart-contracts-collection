// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SelfDestructPiggy {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function breakPiggy() external {
        require(msg.sender == owner, "Not owner");
        selfdestruct(payable(owner));
    }
}
