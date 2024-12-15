// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Voting{

    struct Voter{
        bool hasVoted;
        uint256 choice;
    }

    mapping (address => Voter) public votersData;

    error UserHasAlreadyVoted();

    function registerVote(uint256 choice) public {
        require(!votersData[msg.sender].hasVoted, UserHasAlreadyVoted());
        votersData[msg.sender].hasVoted = true;
        votersData[msg.sender].choice = choice;
    }
}