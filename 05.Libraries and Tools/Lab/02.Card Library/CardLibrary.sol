// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

struct Card {
    uint256 id;
    string name;
}

library CardLibrary {
    function isCardExists(Card[] memory self, uint256 id)
        internal
        pure
        returns (bool)
    {
        uint256 cardsLength = self.length; // Cache the length of the array
        for (uint256 i = 0; i < cardsLength; i++) {
            if (self[i].id == id) {
                return true;
            }
        }
        return false;
    }

    function findCardIndex(Card[] memory self, uint256 id)
        internal
        pure
        returns (uint256)
    {
        for (uint256 i = 0; i < self.length; i++) {
            if (self[i].id == id) {
                return i;
            }
        }
        return type(uint256).max; // Return an invalid index if not found
    }

    function removeAt(Card[] storage self, uint256 index) internal {
        require(index < self.length, "Index out of bounds");
        self[index] = self[self.length - 1];
        self.pop();
    }
}
