// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {
    Ownable
} from "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";
import {
    IERC20
} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract pro_bridge is Ownable {
    mapping(address => mapping(address => uint256) list) allowance;
    address Pro;

    event depositedPro(address toAddress, uint256 amount);
    event invocationToBurnBPRO(address by, uint256 amount);

    constructor(address _Pro) Ownable(msg.sender) {
        Pro = _Pro;
    }

    function receiveAmount(IERC20 tokenAddress, uint256 amount) public payable {
        require(address(tokenAddress) == Pro, "unauthorized token");
        require(
            tokenAddress.allowance(msg.sender, address(this)) >= amount,
            "insufficient allowance for spending"
        );
        require(
            tokenAddress.transferFrom(msg.sender, address(this), amount),
            "error in transferring"
        );
        emit depositedPro(msg.sender, msg.value);
    }

    function burnedBPro(
        IERC20 tokenAddress,
        address to,
        uint256 amount
    ) public onlyOwner {
        require(address(tokenAddress) == Pro, "invalid token address");
        require(
            tokenAddress.balanceOf(to) >= amount,
            "insufficient balance err by custom check"
        );
        tokenAddress.transfer(to, amount);
    }

    function getBackPro(
        IERC20 tokenAddress,
        address by,
        uint256 amount
    ) public {
        require(address(tokenAddress) == Pro, "invalid token address");
        require(
            msg.sender == by,
            "only the account holder can call back for token"
        );
        emit invocationToBurnBPRO(by, amount);
    }
}
