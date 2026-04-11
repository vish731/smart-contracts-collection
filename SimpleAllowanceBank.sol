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
        require(amt > 0, "nothing");

        credit[msg.sender] = 0;

        (bool ok,) = payable(msg.sender).call{value: amt}("");
        require(ok, "transfer fail");
    }
}
