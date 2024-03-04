// SPDX-License-Identifier: Unlicenced
pragma solidity ^0.8.24;

import "openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "openzeppelin/contracts/utils/Counters.sol";
import "openzeppelin/contracts/utils/Strings.sol";
import "openzeppelin/contracts/utils/Base64.sol";

contact ChainBattles is ERC721URIStorage {
    using Strings for unit256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) public tokenIdtoLevels;

    constructor() ERC721("Chain Battles", "CBTLS") {

    }
}
// start video at 16:30