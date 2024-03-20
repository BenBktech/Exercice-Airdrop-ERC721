// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract BBKIsERC721 is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;

    /* A COMPLETER : Déclaration de la Merkle Root */
    string public baseURI;
    using Strings for uint;

    mapping(address => bool) private hasMinted;

    constructor(address initialOwner, bytes32 _merkleRoot, string memory _baseURI)
        ERC721("Alyra", "ALY")
        Ownable(initialOwner)
    {
        /* A COMPLETER : Stocker ici la Merkle Root */
        baseURI = _baseURI;
    }

    /**
    * @notice Allows a whitelisted user to mint tokens
    *
    * @param _to The token receiver
    * @param _proof The merkle proof
    **/
    function safeMint(address _to, bytes32[] calldata _proof) public {
        /* A COMPLETER : Vérifier que _to est Whitelisted */
        require(!hasMinted[msg.sender], "NFT already minted");
        hasMinted[msg.sender] = true;
        uint256 tokenId = _nextTokenId++;
        _safeMint(_to, tokenId);
    }

    /**
    * @notice Change the merkle root
    *
    * @param _merkleRoot the new merkle root
    **/
    function setMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        /* A COMPLETER : Stocker ici la merkle root */
    }

    /**
    * @notice Check if an address is whitelisted or not
    * 
    * @param _account The account checked
    * @param _proof The merkle proof
    *
    * @return bool return true if the address is whitelisted, false otherwise
    **/
    function isWhitelisted(address _account, bytes32[] calldata _proof) internal view returns(bool) {
        /* A COMPLETER : Vérifier que l'adresse fait partir de l'arbre de Merkle défini par sa raçine */
    }

    // The following functions are overrides required by Solidity.
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        _requireOwned(tokenId);
        return string(abi.encodePacked(baseURI, tokenId.toString(), ".json"));
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}