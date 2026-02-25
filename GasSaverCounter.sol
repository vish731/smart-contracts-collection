// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract GasSaverCounter {
    uint256 public count;

    function inc() external {
        unchecked {
            count++;
        }
    }
}
