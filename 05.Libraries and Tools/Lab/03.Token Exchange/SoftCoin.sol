// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// SoftCoin Token
contract SoftCoin is ERC20, Ownable {
    constructor(address initialOwner) ERC20("SoftCoin", "SFT") Ownable(initialOwner) {}

    // Mint function for SoftCoin
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}