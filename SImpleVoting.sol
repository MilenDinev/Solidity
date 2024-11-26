// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

enum VotingOptions {
    CandidateOne, //0
    CandidateTwo // 1
}

contract SimpleVoting {


    bool public votingEnded = false;

    address public candidate1 = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;
    address public candidate2 = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;


    uint256 public votesCandidate1;
    uint256 public votesCandidate2;

    uint256 private eligibleAge = 18;

    error InvalidCandidate();
    error NoWinner();
    // uint256 public votesCandidate1;
    // uint256 public votesCandidate2;
    // uint256 private _votesCandidate2; // private is with underscore

    address public owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public winner;

    function vote (address candidate) external {
        //require(candidate == candidate1 || candidate == candidate2, "Invalid candidate!!!"); // second option for errror message
        require(!votingEnded, "Voting Already Ended");
        if (candidate == candidate1){
            votesCandidate1++;

            if (votesCandidate1 > 5){
                votingEnded = true;
            }

        } else if (candidate == candidate2){
            votesCandidate2++;

            if (votesCandidate2 > 5){
                votingEnded = true;
            }

        } else {
            //revert("Invalid candidate!");
            revert InvalidCandidate();
        }
    }

    function checkEligibility (uint256 age) public view returns (bool eligibility){       
        if (age < eligibleAge){
            revert("Under 18 years old");
        }else{
            return true;
        }
    }

    function chooseWinner() external {
        require(msg.sender == owner, "You are not authorised to choose the winner");
        require(!votingEnded, "Voting Already Ended");
        if(votesCandidate1 > votesCandidate2){
            winner = candidate1;
            votingEnded = true;
        }else if(votesCandidate2 > votesCandidate1){
            winner = candidate2;
            votingEnded = true;
        }else{
            revert NoWinner();
        }
    }
}

    // function vote (uint256 candidateNumber) external returns (uint256 votesCandidate) {
        
    //     if (candidateNumber == 1)
    //     {
    //         return votesCandidate1++;
    //     }

    //     if (candidateNumber == 2)
    //     {
    //         return votesCandidate2++;
    //     }
    // }
