// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LPToken {

    string public name = "LP Token";
    string public symbol = "LPT";
    uint8 public decimals = 18;
    uint public totalSupply;

    address public dex;

    mapping(address => uint) public balanceOf;

    constructor(address _dex) {
        dex = _dex;
    }

    modifier onlyDEX() {
        require(msg.sender == dex, "Only DEX can call");
        _;
    }

    function mint(address to, uint amount) external onlyDEX {
        balanceOf[to] += amount;
        totalSupply += amount;
    }

    function burn(address from, uint amount) external onlyDEX {
        require(balanceOf[from] >= amount, "Not enough LP tokens");
        balanceOf[from] -= amount;
        totalSupply -= amount;
    }
}
