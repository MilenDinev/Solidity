// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {UniCoin} from "./UniCoin.sol";

// UniCoin Token
contract UniCoin is ERC20, Ownable {
    constructor(address initialOwner) ERC20("UniCoin", "UNI") Ownable(initialOwner) {}
    
    // Mint function for UniCoin (only callable by the exchange)
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
