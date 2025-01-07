// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {PaymentLib} from "./lib/PaymentLib.sol";

contract PaymentProcessor is AccessControl {
    using PaymentLib for address payable;

    bytes32 public constant TREASURY_ROLE = keccak256("TREASURY_ROLE");

    address payable public treasury;
    uint256 public allocationPercentage; // Percentage allocated to the treasury (e.g., 20 for 20%)

    event TransferCompleted(address indexed sender, address indexed recipient, uint256 amount);
    event TreasuryAllocation(address indexed treasury, uint256 amount);
    event TreasuryUpdated(address indexed oldTreasury, address indexed newTreasury);
    event AllocationPercentageUpdated(uint256 oldPercentage, uint256 newPercentage);

    constructor(address payable _treasury, uint256 _allocationPercentage) {
        require(_treasury != address(0), "Treasury address cannot be zero");
        require(_allocationPercentage <= 100, "Allocation percentage cannot exceed 100");

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(TREASURY_ROLE, msg.sender);

        treasury = _treasury;
        allocationPercentage = _allocationPercentage;
    }

    function updateTreasury(address payable newTreasury) external onlyRole(TREASURY_ROLE) {
        require(newTreasury != address(0), "Treasury address cannot be zero");
        emit TreasuryUpdated(treasury, newTreasury);
        treasury = newTreasury;
    }

    function updateAllocationPercentage(uint256 newPercentage) external onlyRole(TREASURY_ROLE) {
        require(newPercentage <= 100, "Allocation percentage cannot exceed 100");
        emit AllocationPercentageUpdated(allocationPercentage, newPercentage);
        allocationPercentage = newPercentage;
    }

    function processPayment(address payable recipient) external payable {
        require(msg.value > 0, "Payment amount must be greater than zero");
        require(recipient != address(0), "Recipient cannot be the zero address");

        uint256 treasuryAmount = (msg.value * allocationPercentage) / 100;
        uint256 recipientAmount = msg.value - treasuryAmount;

        // Transfer to treasury
        if (treasuryAmount > 0) {
            treasury.transferETH(treasuryAmount);
            emit TreasuryAllocation(treasury, treasuryAmount);
        }

        // Transfer to recipient
        recipient.transferETH(recipientAmount);
        emit TransferCompleted(msg.sender, recipient, recipientAmount);
    }

    // Receive function to accept ETH deposits
    receive() external payable {}
}