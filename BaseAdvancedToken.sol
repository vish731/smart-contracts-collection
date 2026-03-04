// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/*
 * Advanced ERC20 for Base — OZ v5 compatible
 */

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract BaseAdvancedToken is
    ERC20Burnable,
    ERC20Permit,
    Pausable,
    AccessControl
{
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    uint256 public maxWalletAmount;
    bool public maxWalletEnabled = true;

    event MaxWalletUpdated(uint256 newAmount);
    event MaxWalletToggle(bool enabled);

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 initialSupply_,
        uint256 maxWallet_
    ) ERC20(name_, symbol_) ERC20Permit(name_) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);

        maxWalletAmount = maxWallet_;
        _mint(msg.sender, initialSupply_);
    }

    // =========================
    // Pause Controls
    // =========================

    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    // =========================
    // Mint
    // =========================

    function mint(address to, uint256 amount)
        external
        onlyRole(MINTER_ROLE)
    {
        _mint(to, amount);
    }

    // =========================
    // Max Wallet Controls
    // =========================

    function setMaxWallet(uint256 amount)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        maxWalletAmount = amount;
        emit MaxWalletUpdated(amount);
    }

    function toggleMaxWallet(bool enabled)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        maxWalletEnabled = enabled;
        emit MaxWalletToggle(enabled);
    }

    // =========================
    // OZ v5 Transfer Hook
    // =========================

    function _update(
        address from,
        address to,
        uint256 amount
    ) internal override whenNotPaused {
        if (
            maxWalletEnabled &&
            to != address(0) &&
            !hasRole(DEFAULT_ADMIN_ROLE, to)
        ) {
            require(
                balanceOf(to) + amount <= maxWalletAmount,
                "Exceeds max wallet"
            );
        }

        super._update(from, to, amount);
    }
}
