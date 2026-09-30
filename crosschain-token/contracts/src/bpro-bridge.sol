// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Ownable} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface ContractBPRO is IERC20{
    function mint(address to,uint256 amount) external;
    function burn(address from, uint256 amount) external;
}

contract bpro_bridge is Ownable{
    mapping(address=>uint256)balanceOf;
    mapping(address=>mapping(address =>uint256)list) allowance;
    address BPro;

    event burnedBPRO(address from,uint256 amount);

    constructor(address _BPro)Ownable(msg.sender){
        BPro=_BPro;
    }   

    function mintBPRO(ContractBPRO tokenAddress,address to, uint256 amount)public onlyOwner(){
        require(address(tokenAddress)==BPro,"invalid token address");
        tokenAddress.mint(to,amount);
    }

    function burnBPRO(ContractBPRO tokenAddress,address from , uint256 amount)public{
        require(address(tokenAddress)==BPro,"invalid token address");
        require(tokenAddress.balanceOf(from)>=amount,"insufficient balance to burn by custom msg");
        tokenAddress.burn(from,amount);
        emit burnedBPRO(from,amount);
    }
}