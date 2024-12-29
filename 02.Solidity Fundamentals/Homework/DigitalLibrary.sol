// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalLibrary {

    enum Status { Active, Outdated, Archived }

    struct EBook {
        string title;
        string author;
        uint256 publicationDate;
        uint256 expirationDate;
        Status status;
        address primaryLibrarian;
        uint256 readCount;
    }

    mapping(uint256 => EBook) public eBooks;
    mapping(uint256 => mapping(address => bool)) public authorizedLibrarians;
    uint256 public ebookCount;

    modifier onlyPrimaryLibrarian(uint256 ebookId) {
        require(
            eBooks[ebookId].primaryLibrarian == msg.sender,
            "Only primary librarian can perform this action"
        );
        _;
    }

    modifier onlyAuthorizedLibrarian(uint256 ebookId) {
        require(
            authorizedLibrarians[ebookId][msg.sender] ||
            eBooks[ebookId].primaryLibrarian == msg.sender,
            "Only authorized librarians can perform this action"
        );
        _;
    }

    function createEBook(
        string calldata title,
        string calldata author,
        uint256 expirationDays
    ) external {
        uint256 ebookId = ebookCount++;
        eBooks[ebookId] = EBook({
            title: title,
            author: author,
            publicationDate: block.timestamp,
            expirationDate: block.timestamp + (expirationDays * 1 days),
            status: Status.Active,
            primaryLibrarian: msg.sender,
            readCount: 0
        });
        authorizedLibrarians[ebookId][msg.sender] = true;
    }

    function addLibrarian(uint256 ebookId, address librarian)
        external
        onlyPrimaryLibrarian(ebookId)
    {
        authorizedLibrarians[ebookId][librarian] = true;
    }

    function extendExpirationDate(uint256 ebookId, uint256 additionalDays)
        external
        onlyAuthorizedLibrarian(ebookId)
    {
        eBooks[ebookId].expirationDate += additionalDays * 1 days;
    }

    function changeStatus(uint256 ebookId, Status newStatus)
        external
        onlyPrimaryLibrarian(ebookId)
    {
        eBooks[ebookId].status = newStatus;
    }

    function checkExpiration(uint256 ebookId) external returns (bool) {
        EBook storage ebook = eBooks[ebookId];
        ebook.readCount++;
        return block.timestamp > ebook.expirationDate;
    }
}
