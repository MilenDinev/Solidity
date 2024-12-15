// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract DecentralizedSavingsAccount {
    struct SavingsAccount {
        uint256 balance;
        address owner;
        uint256 creationTime;
        uint256 lockPeriod;
    }

    mapping(address => SavingsAccount[]) internal savingPlans;

    function createSavingsPlan(uint256 lockPeriod) external payable{
        SavingsAccount memory newAccount = SavingsAccount({
            balance: msg.value,
            owner: msg.sender,
            creationTime: block.timestamp,
            lockPeriod: lockPeriod
        });

        savingPlans[msg.sender].push(newAccount);
    }

    function addFundsToSavingPlan(uint256 planNumber) external payable{
        savingPlans[msg.sender][planNumber].balance += msg.value;
    }

    function viewSavingsPlan(uint256 planNumber) external view returns(uint256 balance, address owner, uint256 creationTime, uint256 lockPeriod){
        SavingsAccount memory currentAccount = savingPlans[msg.sender][planNumber];
        return (currentAccount.balance, currentAccount.owner, currentAccount.creationTime, currentAccount.lockPeriod);
    }

    function withdrawFunds(uint256 planNumber) external payable{
        require(savingPlans[msg.sender][planNumber].balance >= msg.value, "Isuficient funds!");
        savingPlans[msg.sender][planNumber].balance -= msg.value;
    }
}
