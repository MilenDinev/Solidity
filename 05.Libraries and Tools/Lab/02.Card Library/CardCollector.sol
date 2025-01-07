// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CardLibrary} from "./CardLibrary.sol";
import {Card} from "./CardLibrary.sol";

contract CardCollector {
    using CardLibrary for Card[];
    mapping(address => Card[]) public collections;

    error AlreadyExists();
    error CardDoesNotExist();

    modifier onlyOwner(uint256 id) {
        require(
            collections[msg.sender].isCardExists(id) == true, CardDoesNotExist()
        );
        _;
    }

    function createCard(uint256 id, string calldata name) public {
        if (collections[msg.sender].isCardExists(id)) {
            revert AlreadyExists();
        }

        Card memory card = Card({id: id, name: name});
        collections[msg.sender].push(card);
    }

    // Function to remove a card by ID
    function removeCard(uint256 id) public onlyOwner(id) {
        uint256 index = collections[msg.sender].findCardIndex(id);
        if (index >= collections[msg.sender].length) {
            revert CardDoesNotExist();
        }

        // Remove the card using the swap-and-pop method
        collections[msg.sender].removeAt(index);
    }
}
