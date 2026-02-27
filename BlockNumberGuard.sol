// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BlockNumberGuard {
    mapping(address => uint256) public lastBlock;

    function useOncePerBlock() external {
        require(lastBlock[msg.sender] != block.number, "same block");
        lastBlock[msg.sender] = block.number;
    }
}
