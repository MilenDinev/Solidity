// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;


contract CompoundInterestCalculator { 
    /**
     * @dev Calculates compound interest using mathematical exponentiation.
     * @param principal Initial amount deposited.
     * @param rate Annual interest rate (percentage).
     * @param yearsCompound Number of years for compounding.
     * @return finalAmount Final balance after applying compound interest.
     */
    function calculateCompoundInterest(uint256 principal, uint256 rate, uint256 yearsCompound) 
        public 
        pure 
        returns (uint256 finalAmount) 
    {
        require(principal > 0, "Principal must be greater than zero");
        require(rate > 0, "Rate must be greater than zero");
        require(yearsCompound > 0, "Years must be greater than zero");

        // Calculate compound interest using the formula: A = P * (1 + r/100)^n
        finalAmount = principal * power((100 + rate), yearsCompound) / (100**yearsCompound);

        return finalAmount;
    }
    
    /**
     * @dev Internal function to calculate base^exponent.
     * @param base The base number.
     * @param exponent The exponent (must be a non-negative integer).
     * @return result Result of base^exponent.
     */
    function power(uint256 base, uint256 exponent) internal pure returns (uint256 result) {
        result = 1;
        for (uint256 i = 0; i < exponent; i++) {
            result *= base;
        }
    }
}