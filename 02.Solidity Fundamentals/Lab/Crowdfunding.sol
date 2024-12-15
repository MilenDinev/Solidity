// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;


contract Crowdfunding{

    struct Campaign{
        uint256 goalAmount;
        uint256 totalContributed;
        uint256 startTime;
        uint256 endTime;
        bool isActive;
    }
     
     Campaign public currentCampaign;

    mapping (address => uint256) public contributions;

    constructor(uint256 _goalAmount){
        currentCampaign.goalAmount = _goalAmount;
        currentCampaign.startTime = block.timestamp;
        currentCampaign.endTime = 110 seconds;
        currentCampaign.isActive = true;
    }

    function contribute() external payable {
        require(currentCampaign.isActive, "Campaign is not active!");
        
        if(block.timestamp > currentCampaign.startTime + currentCampaign.endTime){
            currentCampaign.isActive = false;
        }else{
            contributions[msg.sender] += msg.value;
            currentCampaign.totalContributed += contributions[msg.sender];
            if(currentCampaign.totalContributed >= currentCampaign.goalAmount){
                currentCampaign.isActive = false;
            }
        }
    }

    function withdraw() external {
        currentCampaign.totalContributed -= contributions[msg.sender];
        contributions[msg.sender] = 0;
    }

    function checkGoalReached() external view returns (bool isGoalReached){
        isGoalReached = currentCampaign.totalContributed >= currentCampaign.goalAmount;
    }
}