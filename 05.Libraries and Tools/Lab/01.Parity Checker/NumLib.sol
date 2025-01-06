// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library NumLib{

    function isEven(uint256 a) public pure returns (bool){
        if (a % 2 == 0){
            return true;
        }
        return false;
    }
}