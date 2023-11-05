// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Proof_of_Work is ERC721URIStorage, Ownable {
    uint256 public constant maxMintableNFTs = 88;
    uint256 public totalMintedNFTs = 0;
    address public paymentAddress; // Payment address

    constructor(
        address initialOwner,
        address _paymentAddress
    ) Ownable(initialOwner) ERC721("Proof of Work", "AuxPoW") {
        paymentAddress = _paymentAddress; // Set the initial payment address to the contract's address
    }

    // Function to allow the owner to change the payment address.
    function setPaymentAddress(address newPaymentAddress) public onlyOwner {
        paymentAddress = newPaymentAddress;
    }

    function mintNFT(
        string memory tokenURI
    ) public payable virtual returns (uint256) {
        require(totalMintedNFTs < maxMintableNFTs, "Max NFT limit reached");
        require(msg.value >= 20000000000000000, "Not enough ELA sent!");

        // Send the payment to the specified payment address
        payable(paymentAddress).transfer(msg.value);

        totalMintedNFTs++;

        _mint(msg.sender, totalMintedNFTs);
        _setTokenURI(totalMintedNFTs, tokenURI);

        return totalMintedNFTs;
    }

    function setTokenURI(
        uint256 tokenId,
        string memory newTokenURI
    ) public onlyOwner {
        require(tokenId <= totalMintedNFTs, "Token ID does not exist");
        _setTokenURI(tokenId, newTokenURI);
    }
}
