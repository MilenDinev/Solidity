// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InterestCalculator {
    function calculateCompoundInterest(
        uint256 principal,
        uint256 rate,
        uint256 yearsCompound
    ) public pure returns (uint256 futureBalance) {
        return principal * power((100 + rate), yearsCompound) / (100**yearsCompound);
    }

    function power(uint256 base, uint256 exponent)
        private
        pure
        returns (uint256 result)
    {
        result = 1;
        for (uint256 i = 0; i < exponent; i++) {
            result *= base;
        }
    }
}
