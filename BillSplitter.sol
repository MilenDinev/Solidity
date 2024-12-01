// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract BillSplitter{

    error InvalidAmount();

    function splitExpense(uint256 totalAmount, uint256 numPeople)public pure returns (uint256 amountEach){
        require(totalAmount % numPeople == 0, InvalidAmount());

        return totalAmount / numPeople;
    }
}