// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PaymentProcessor} from "./PaymentProcessor.sol";

// Merchant Contract
contract Merchant is PaymentProcessor {
    mapping(address => bool) public loyalCustomers;

    string private insufficientBalanceForRefundAndBonusMessage = "Insufficient balance for refund and bonus"; 
    
    event LoyaltyBonusGranted(address indexed customer, uint256 bonus);

    function setLoyalCustomer(address customer, bool isLoyal) external {
        loyalCustomers[customer] = isLoyal;
    }

    function refundPayment(address customer, uint256 amount) external override {
        require(balances[customer] >= amount, insufficientBalanceForRefundMessage );

        uint256 refundAmount = amount;
        if (loyalCustomers[customer]) {
            uint256 bonus = (amount * 1) / 100; // 1% bonus
            refundAmount += bonus;
            require(balances[customer] >= refundAmount, insufficientBalanceForRefundAndBonusMessage);
            emit LoyaltyBonusGranted(customer, bonus);
        }

        balances[customer] -= refundAmount;
        payable(customer).transfer(refundAmount);
        emit RefundProcessed(customer, refundAmount);
    }
}