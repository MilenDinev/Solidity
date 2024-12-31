// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventTicketNFT {
    string public name;
    string public symbol;
    uint256 private _nextTokenId;
    address private _owner;

    struct TicketMetadata {
        string eventName;
        string eventDate;
        string seatNumber;
    }

    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => TicketMetadata) public ticketDetails;

    modifier onlyOwner() {
        require(msg.sender == _owner, "Caller is not the contract owner");
        _;
    }

    modifier tokenExists(uint256 tokenId) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        _;
    }

    constructor() {
        name = "EventTicketNFT";
        symbol = "ETN";
        _owner = msg.sender;
        _nextTokenId = 1;
    }

    function mintTicket(
        address to,
        string memory eventName,
        string memory eventDate,
        string memory seatNumber
    ) external onlyOwner {
        require(to != address(0), "Cannot mint to the zero address");

        uint256 tokenId = _nextTokenId;
        _nextTokenId++;

        _owners[tokenId] = to;
        _balances[to] += 1;

        ticketDetails[tokenId] = TicketMetadata({
            eventName: eventName,
            eventDate: eventDate,
            seatNumber: seatNumber
        });
    }

    function transferTicket(
        address from,
        address to,
        uint256 tokenId
    ) external onlyOwner tokenExists(tokenId) {
        require(from == _owners[tokenId], "Transfer not authorized by ticket owner");
        require(to != address(0), "Cannot transfer to the zero address");

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;
    }

    function getTicketMetadata(uint256 tokenId)
        external
        view
        tokenExists(tokenId)
        returns (
            string memory eventName,
            string memory eventDate,
            string memory seatNumber
        )
    {
        TicketMetadata memory metadata = ticketDetails[tokenId];
        return (metadata.eventName, metadata.eventDate, metadata.seatNumber);
    }

    function ownerOf(uint256 tokenId) external view tokenExists(tokenId) returns (address) {
        return _owners[tokenId];
    }

    function balanceOf(address owner) external view returns (uint256) {
        require(owner != address(0), "Zero address query for balance");
        return _balances[owner];
    }
}