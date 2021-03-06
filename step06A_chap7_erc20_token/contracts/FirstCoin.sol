//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract FirstCoin  {

    string public constant name = "FirstCoin";
    string public constant symbol = "MFC";
    uint8 public constant decimals = 18;  


    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);

    mapping(address => uint256) private balances;
    mapping(address => mapping (address => uint256)) private allowed;
    uint256 private totalSupply_;
    address private owner_; 

    constructor(uint256 total) {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
        owner_ = msg.sender;
        console.log("Total supply created and assigned to Owner: ", totalSupply_);
    }

    function owner() public view returns (address){
        return owner_;
    }

    function totalSupply() public view returns (uint256) {
        console.log("Total supply: ", totalSupply_);
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
        console.log("The address: '%s' has these tokens: '%s'", tokenOwner, balances[tokenOwner]);
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint numTokens) public returns (bool) {
        require(numTokens <= balances[msg.sender], "Not enough tokens.");
        balances[msg.sender] = balances[msg.sender] - numTokens;
        balances[receiver] = balances[receiver] + numTokens;
        emit Transfer(msg.sender, receiver, numTokens);
        console.log("The owner: '%s' has has transfered '%s' tokens to receiver '%s'", msg.sender, numTokens, receiver);
        return true;
    }

    function approve(address delegate, uint numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        console.log("The owner: '%s' has has approved '%s' tokens to delegate '%s'", msg.sender, numTokens, delegate);
        return true;
    }


    function allowance(address tokenowner, address delegate) public view returns (uint) {
        console.log("The owner: '%s' has approved '%s' tokens for the delegate '%s'", tokenowner, allowed[tokenowner][delegate], delegate);
        return allowed[tokenowner][delegate];
    }

    function transferFrom(address ownerAddr, address buyer, uint numTokens) public returns (bool) {
        require(numTokens <= balances[ownerAddr]);
        require(numTokens <= allowed[ownerAddr][msg.sender]);
        balances[ownerAddr] = balances[ownerAddr] - numTokens;
        allowed[ownerAddr][msg.sender] = allowed[ownerAddr][msg.sender] - numTokens;
        balances[buyer] = balances[buyer] + numTokens;
        emit Transfer(ownerAddr, buyer, numTokens);
        console.log("With owners: '%s' permission delegate '%s' is transfering '%s' tokens to the buyer", ownerAddr, msg.sender, numTokens);
        return true;
    }


}
