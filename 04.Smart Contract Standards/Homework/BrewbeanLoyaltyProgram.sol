// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseLoyaltyProgram} from "./BaseLoyaltyProgram.sol";

// ERC20-Compliant BrewBean Points Contract
contract BrewBeanPoints is BaseLoyaltyProgram {
    string public name = "BrewBean Points";
    string public symbol = "BBP";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    address public owner;

    event Rewarded(address indexed customer, uint256 amount);
    event Redeemed(address indexed customer, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function _authorizeReward(address customer, uint256 amount) internal override {
        require(customer != address(0), "Invalid customer address");
        require(amount > 0, "Reward amount must be greater than zero");
        emit Rewarded(customer, amount);
    }

    function addPartner(address partner) external override onlyOwner {
        require(partner != address(0), "Invalid partner address");
        _partners[partner] = true;
    }

    function removePartner(address partner) external override onlyOwner {
        require(partner != address(0), "Invalid partner address");
        _partners[partner] = false;
    }

    function burnPoints(address customer, uint256 amount) external {
        require(_balances[customer] >= amount, "Insufficient points to burn");
        _balances[customer] -= amount;
        totalSupply -= amount;
        emit Redeemed(customer, amount);
    }

    function balanceOf(address customer) external view returns (uint256) {
        return _balances[customer];
    }
}
