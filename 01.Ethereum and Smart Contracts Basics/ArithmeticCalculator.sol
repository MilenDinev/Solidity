// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract ArithmeticCalculator{

    function add(uint256 a, uint256 b) public pure returns (uint256 sum){
        sum = a + b;
    }

    function subtract(uint256 a, uint256 b) public pure returns (uint256 difference){
        difference = a - b;
    }

    function multiply(uint256 a, uint256 b) public pure returns (uint256 product){
        product = a * b;
    }

    function divide(uint256 a, uint256 divisor) public pure returns (uint256 division){
        require(divisor != 0, "Divisor should not be 0");
        division = a / divisor;
    }
}
