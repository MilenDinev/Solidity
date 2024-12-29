// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Base Contract
contract PaymentProcessor {
    mapping(address => uint256) public balances;

    string internal insufficientBalanceForRefundMessage = "Insufficient balance for refund";
    string private PaymentIsNegativeMessage = "Payment must be greater than zero"; 

    event PaymentReceived(address indexed customer, uint256 amount);
    event RefundProcessed(address indexed customer, uint256 amount);

    function receivePayment() external payable {
        require(msg.value > 0, PaymentIsNegativeMessage);
        balances[msg.sender] += msg.value;
        emit PaymentReceived(msg.sender, msg.value);
    }

    function checkBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    function refundPayment(address customer, uint256 amount) external virtual {
        require(balances[customer] >= amount, insufficientBalanceForRefundMessage);
        balances[customer] -= amount;
        payable(customer).transfer(amount);
        emit RefundProcessed(customer, amount);
    }
}