// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleMultiSig {
    address[2] public owners;
    mapping(address => bool) public approved;

    constructor(address _a, address _b) {
        owners[0] = _a;
        owners[1] = _b;
    }

    function approve() external {
        require(msg.sender == owners[0] || msg.sender == owners[1]);
        approved[msg.sender] = true;
    }

    function execute(address payable to) external {
        require(approved[owners[0]] && approved[owners[1]], "Need both");
        to.transfer(address(this).balance);
        approved[owners[0]] = false;
        approved[owners[1]] = false;
    }

    receive() external payable {}
}
