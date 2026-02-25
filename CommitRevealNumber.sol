// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CommitRevealNumber {
    mapping(address => bytes32) public commits;
    mapping(address => uint256) public numbers;

    function commit(bytes32 hash) external {
        commits[msg.sender] = hash;
    }

    function reveal(uint256 num, string calldata secret) external {
        require(
            keccak256(abi.encode(num, secret)) == commits[msg.sender],
            "Invalid reveal"
        );
        numbers[msg.sender] = num;
    }
}
