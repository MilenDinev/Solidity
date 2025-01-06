// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {NumLib} from "./NumLib.sol";

contract ParityChecker{

    function checkParity(uint256 _value) public pure returns(bool){
        return NumLib.isEven(_value);
    }
}