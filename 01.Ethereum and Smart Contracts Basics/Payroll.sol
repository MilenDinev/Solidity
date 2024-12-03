// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;


contract Payroll {

    error InvalidSalary();
    error InvalidRating();
    function calculatePaycheck(uint256 salary, uint256 rating) public pure returns(uint256 totalSalary){
        require(salary > 0,  InvalidSalary());
        require(rating > 0 && rating <=10,  InvalidRating());

        if(rating > 8){

            return salary+= salary * 1/10;
        }

        return salary;
    }

}