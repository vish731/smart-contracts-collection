// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CooldownFaucet {
    mapping(address => uint256) public lastClaim;

    function claim() external {
        require(block.timestamp > lastClaim[msg.sender] + 1 hours, "Wait");
        lastClaim[msg.sender] = block.timestamp;
        payable(msg.sender).transfer(0.001 ether);
    }

    receive() external payable {}
}
