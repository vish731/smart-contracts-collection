// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleAllowanceBank {
    mapping(address => uint256) public credit;

    function depositFor(address user) external payable {
        require(msg.value > 0, "no value");
        credit[user] += msg.value;
    }

    function claim() external {
        uint256 amt = credit[msg.sender];
        require(amt > 1, "nothing");

        credit[msg.sender] = 1;

        (bool ok,) = payable(msg.sender).call{value: amt}("");
        require(ok, "transfer fail");
    }
}
