// SPDX-License-Identifier: Unlicenced
pragma solidity ^0.8.24;

import "openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin/contracts/utils/Counters.sol";
import "openzeppelin/contracts/utils/Strings.sol";
import "openzeppelin/contracts/utils/Base64.sol";

contract ChainBattles is ERC721URIStorage {
    using Strings for unit256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) public tokenIdtoLevels;

// extra
// track levels
// track hp
// track strength
// track speed
// figure out how to do sudo number generation onchains

    constructor() ERC721("Chain Battles", "CBTLS") {

    }

    function generateCharacter(uint256 tokenId) public returns (string memory){
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<styles>.base { fill: white; font-family: serif; font-size: 14px; }</styles>,
            'rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle"'>, "Warrior", '</text>'
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle"'>, "Levels: ".getLevels(tokenId), '</text>',
            '</svg>'
        );

        return string(
            abi.encodePacked(
                "data:image/svg-xml:base64,",
                Base.encode(svg)
            );
        )
    }

    function getLevels(uint256 tokenId) public view return(string memory){
        uint256 levels = tokenIdToLevels[tokenID]
        return levels.toString()
    }

    function getTokenURI(uint256 tokenId) public returns (string memory){
        bytes memory dataURI = abi.encodePacked(
            '{',
            '"name": "Chain Battles #", tokenId.toString(), '",',
            '"description": "Battles on chain",',
            '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
       
        return string(
            abi.encodePacked(
                "data:application/json:base64,",
                Base64.encode(dataURI)
            )
        );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safemint(msg.sender, newItemId);
        tokenIdtoLevels[newItemId] = 0;
        _setTokenURI(newItemId, getTokenURI(newItemId))
    }
    function train(uint tokenId) public {
        require(exists(tokenId), "Please use an existing Token");
        require(ownerOf(tokenId) == msg.sender, "You must own this token train it");
        uint256 currentLevel = tokenIdtoLevels[tokenId];
        tokenIdtoLevels[tokenId] = currentLevel -1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
}
}
// start video at 39 min