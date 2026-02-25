// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LimitedMintCounter {
    uint256 public total;
    uint256 public constant MAX = 100;

    function mint() external {
        require(total < MAX, "Sold out");
        total++;
    }
}
