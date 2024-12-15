// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;


contract LoanCalculator{
    
    error InvalidInteresRate();
    error InvalidLoanPeriod();

    function calculateTotalPayable(uint256 principal, uint256 rate, uint256 period) public pure returns(uint256 totalAmount){
        totalAmount = principal + (principal * rate * period / 100);
    }
}