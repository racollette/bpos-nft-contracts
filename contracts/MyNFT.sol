// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage {
    uint256 public constant maxMintableNFTs = 88; // Define the maximum NFTs that can be minted.
    uint256 private totalMintedNFTs = 0; // Keep track of the total minted NFTs.

    constructor() ERC721("MyNFT", "NFT") {}

    function mintNFT(address recipient, string memory tokenURI)
        public
        returns (uint256)
    {
        require(totalMintedNFTs < maxMintableNFTs, "Max NFT limit reached");

        totalMintedNFTs++;

        _mint(recipient, totalMintedNFTs);
        _setTokenURI(totalMintedNFTs, tokenURI);

        return totalMintedNFTs;
    }
}
