// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract deadswitch{
    address public owner;
    address public reciever;
    uint public lastbloc;

    constructor(address _reciever){
        owner=msg.sender;
        reciever=reciever;
        lastbloc=block.number;
    }
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    function stillAlive() public onlyOwner {
        lastbloc = block.number;
    }
    function checkStatus() public view returns (bool){
        return (block.number-lastbloc)<=10;
    }
    function transferBalance() public onlyOwner {
        require(!checkStatus(), "Owner is still alive");
        uint256 balance = address(this).balance;
        payable(reciever).transfer(balance);
    }
    receive() external payable {}


}