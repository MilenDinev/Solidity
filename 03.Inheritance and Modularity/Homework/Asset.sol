// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Asset Contract
contract Asset {
    string public symbol;
    string public name;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;
    string insufficientBalanceMessage = "Insufficient balance"; 

    constructor(string memory _symbol, string memory _name, uint256 _initialSupply) {
        symbol = _symbol;
        name = _name;
        totalSupply = _initialSupply;
        balances[msg.sender] = _initialSupply;
    }

    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, insufficientBalanceMessage);
        balances[msg.sender] -= amount;
        balances[to] += amount;
    }

    function balanceOf(address account) external view returns (uint256) {
        return balances[account];
    }
}
