//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;


import "./IERC721.sol";

/**
 * @title ERC-721 Non-Fungible Token Standard, optional metadata extension
 * @dev See https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md
 */
abstract contract IERC721Metadata is IERC721 {
    function name() external view virtual returns (string memory){}
    function symbol() external view virtual returns (string memory){}
    function tokenURI(uint256 tokenId) external view virtual returns (string memory){}
}
