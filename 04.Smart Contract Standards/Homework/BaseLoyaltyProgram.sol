// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ILoyaltyPoints} from "./Interfaces/ILoyaltyPoints.sol";

// Abstract Base Loyalty Program
abstract contract BaseLoyaltyProgram is ILoyaltyPoints {
    mapping(address => uint256) internal _balances;
    mapping(address => bool) internal _partners;

    modifier onlyPartner() {
        require(_partners[msg.sender], "Caller is not a registered partner");
        _;
    }

    function _authorizeReward(address customer, uint256 amount) internal virtual;

    function rewardPoints(address customer, uint256 amount) external override onlyPartner {
        _authorizeReward(customer, amount);
        _balances[customer] += amount;
    }

    function redeemPoints(address customer, uint256 amount) external override {
        require(_balances[customer] >= amount, "Insufficient points to redeem");
        _balances[customer] -= amount;
    }

    function addPartner(address partner) external virtual;
    function removePartner(address partner) external virtual;
}