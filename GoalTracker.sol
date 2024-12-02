// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract GoalTracker {
    // State variables
    address public owner; // Owner of the contract
    uint256 public goal = 1000; // Goal amount
    uint256 public baseReward = 20; // Base reward amount
    mapping (address spender => uint256 totalSpent) public totalSpending; // User's total spending
    mapping (address user => bool rewardClaimed) public rewardClaimed;
    mapping (address user => uint256 reward) public totalReward; // Tracks if the reward has been claimed

    // Errors
    error GoalNotReached(uint256 totalSpending, uint256 goal);
    error RewardAlreadyClaimed();

    function addSpending(uint256 amount) public {     
        totalSpending[msg.sender] += amount;
        uint256 rewardsToBeClaimed = totalSpending[msg.sender] / goal;     
        totalReward[msg.sender] += baseReward * 5 * rewardsToBeClaimed;
    }

    function claimReward() public {          
        require(totalSpending[msg.sender] >= goal,GoalNotReached(totalSpending[msg.sender], goal));
        require(rewardClaimed[msg.sender] = false, RewardAlreadyClaimed());      
        rewardClaimed[msg.sender] = true;
    }
}