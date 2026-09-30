// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {
    ERC20
} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract proContract is ERC20,Ownable {

    constructor() ERC20("PRO", "P")Ownable(msg.sender){
    }

    function mint(address to,uint256 amount) public onlyOwner(){
        _mint(to,amount);
    }

    function approveSpending(address _addressToApprove,address spender, uint256 amount)public onlyOwner(){
    _approve(_addressToApprove,spender,amount);
    }

}
