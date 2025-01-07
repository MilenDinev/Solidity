// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";

library PaymentLib {
    error InsufficientBalance(uint256 available, uint256 required);
    error TransferFailed(address recipient, uint256 amount);
    error InvalidAddress(address addr);

    function transferETH(address payable self, uint256 amount) internal {
        if (self == address(0)) {
            revert InvalidAddress(self);
        }
        if (address(this).balance < amount) {
            revert InsufficientBalance(address(this).balance, amount);
        }

        (bool success, ) = self.call{value: amount}("");
        if (!success) {
            revert TransferFailed(self, amount);
        }
    }

    function isContract(address self) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(self)
        }
        return size > 0;
    }
}