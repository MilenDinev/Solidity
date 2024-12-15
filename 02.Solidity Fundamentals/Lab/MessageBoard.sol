// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract MessageBoard{

    mapping (address => string[]) public messages;

    function storeMessage (string calldata message) public {
        messages[msg.sender].push(message);
    }

    function previewMessage (string calldata message) public pure returns (string memory draftMessage) {
        draftMessage = string(abi.encodePacked("Draft: " , message));
        return draftMessage;
    }
}