// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PayrollCalculator {
    function calculatorPaycheck(uint256 salary, uint256 rating) public pure {
        if (rating >= 9) {
            salary += (salary * 10) / 100;
        }
    }
}
