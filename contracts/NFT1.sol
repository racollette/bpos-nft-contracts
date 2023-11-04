// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Proof_of_Work is ERC721URIStorage, Ownable {
    uint256 public constant maxMintableNFTs = 88; // Define the maximum NFTs that can be minted.
    uint256 public totalMintedNFTs = 0; // Keep track of the total minted NFTs.

    constructor(
        address initialOwner
    ) Ownable(initialOwner) ERC721("Proof of Work", "AuxPoW") {}

    function mintNFT(
        address recipient,
        string memory tokenURI
    ) public payable virtual returns (uint256) {
        require(totalMintedNFTs < maxMintableNFTs, "Max NFT limit reached");
        require(msg.value >= 20000000000000000, "Not enough ELA sent!");

        totalMintedNFTs++;

        _mint(recipient, totalMintedNFTs);
        _setTokenURI(totalMintedNFTs, tokenURI);

        return totalMintedNFTs;
    }

    // Function to allow the owner to change the tokenURI for a specific NFT.
    function setTokenURI(
        uint256 tokenId,
        string memory newTokenURI
    ) public onlyOwner {
        require(tokenId <= totalMintedNFTs, "Token ID does not exist");
        _setTokenURI(tokenId, newTokenURI);
    }
}
