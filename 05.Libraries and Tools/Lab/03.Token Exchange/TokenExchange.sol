// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import {SoftCoin} from "./SoftCoin.sol";
import {UniCoin} from "./UniCoin.sol";


// Token Exchange Contract
contract TokenExchange is Ownable {
    SoftCoin public softCoin;
    UniCoin public uniCoin;

    constructor(address initialOwner, address _softCoin, address _uniCoin) Ownable(initialOwner){
        softCoin = SoftCoin(_softCoin);
        uniCoin = UniCoin(_uniCoin);
    }

    // Trade SoftCoin for UniCoin
    function trade(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(softCoin.balanceOf(msg.sender) >= amount, "Insufficient SoftCoin balance");
        require(softCoin.allowance(msg.sender, address(this)) >= amount, "Allowance not set for SoftCoin");

        // Transfer SoftCoin from the user to this contract
        softCoin.transferFrom(msg.sender, address(this), amount);

        // Mint an equivalent amount of UniCoin to the user
        uniCoin.mint(msg.sender, amount);
    }
}
