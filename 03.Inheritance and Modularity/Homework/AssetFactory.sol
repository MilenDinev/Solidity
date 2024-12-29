// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Asset} from "./Asset.sol";
// AssetFactory Contract
contract AssetFactory {
    mapping(string => address) public assetAddresses;
    string assetExistsMessage = "Asset with this symbol already exists"; 
    string assetNotExistsMessage = "Asset does not exist"; 

    function createAsset(string memory symbol, string memory name, uint256 initialSupply) external {
        require(assetAddresses[symbol] == address(0), assetExistsMessage);

        Asset newAsset = new Asset(symbol, name, initialSupply);
        assetAddresses[symbol] = address(newAsset);
    }

    function getAssetAddress(string memory symbol) external view returns (address) {
        return assetAddresses[symbol];
    }

    function transferAsset(
        string memory symbol,
        address to,
        uint256 amount
    ) external {
        address assetAddress = assetAddresses[symbol];
        require(assetAddress != address(0), assetNotExistsMessage);

        Asset(assetAddress).transfer(to, amount);
    }

    function balanceOf(string memory symbol, address account) external view returns (uint256) {
        address assetAddress = assetAddresses[symbol];
        require(assetAddress != address(0), assetNotExistsMessage);

        return Asset(assetAddress).balanceOf(account);
    }
}
