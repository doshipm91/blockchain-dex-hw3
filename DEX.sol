// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IToken {
    function transferFrom(address from, address to, uint amount) external returns (bool);
    function transfer(address to, uint amount) external returns (bool);
    function balanceOf(address user) external view returns (uint);
}

interface ILPToken {
    function mint(address to, uint amount) external;
    function burn(address from, uint amount) external;
    function totalSupply() external view returns (uint);
    function balanceOf(address user) external view returns (uint);
}

contract DEX {

    address public tokenA;
    address public tokenB;
    address public lpToken;

    uint public reserveA;
    uint public reserveB;

    constructor(address _tokenA, address _tokenB, address _lpToken) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        lpToken = _lpToken;
    }

    // Add Liquidity
    function addLiquidity(uint amountA, uint amountB) public {

        if (reserveA > 0 || reserveB > 0) {
            require(reserveA * amountB == reserveB * amountA, "Ratio mismatch");
        }

        IToken(tokenA).transferFrom(msg.sender, address(this), amountA);
        IToken(tokenB).transferFrom(msg.sender, address(this), amountB);

        uint shares;
        uint totalShares = ILPToken(lpToken).totalSupply();

        if (totalShares == 0) {
            shares = amountA; // initial case
        } else {
            shares = (amountA * totalShares) / reserveA;
        }

        ILPToken(lpToken).mint(msg.sender, shares);

        reserveA += amountA;
        reserveB += amountB;
    }

    // Remove Liquidity
    function removeLiquidity(uint shares) public {

        uint totalShares = ILPToken(lpToken).totalSupply();

        uint amountA = (shares * reserveA) / totalShares;
        uint amountB = (shares * reserveB) / totalShares;

        ILPToken(lpToken).burn(msg.sender, shares);

        reserveA -= amountA;
        reserveB -= amountB;

        IToken(tokenA).transfer(msg.sender, amountA);
        IToken(tokenB).transfer(msg.sender, amountB);
    }

    // Swap A → B
    function swapAforB(uint amountA) public {

        uint feeAmount = (amountA * 997) / 1000; // 0.3% fee

        uint newReserveA = reserveA + feeAmount;
        uint newReserveB = (reserveA * reserveB) / newReserveA;

        uint amountB = reserveB - newReserveB;

        IToken(tokenA).transferFrom(msg.sender, address(this), amountA);
        IToken(tokenB).transfer(msg.sender, amountB);

        reserveA += feeAmount;
        reserveB -= amountB;
    }

    // Swap B → A
    function swapBforA(uint amountB) public {

        uint feeAmount = (amountB * 997) / 1000;

        uint newReserveB = reserveB + feeAmount;
        uint newReserveA = (reserveA * reserveB) / newReserveB;

        uint amountA = reserveA - newReserveA;

        IToken(tokenB).transferFrom(msg.sender, address(this), amountB);
        IToken(tokenA).transfer(msg.sender, amountA);

        reserveB += feeAmount;
        reserveA -= amountA;
    }

    // Spot Price (A in terms of B)
    function getPriceA() public view returns (uint) {
        return (reserveB * 1e18) / reserveA;
    }

    // Spot Price (B in terms of A)
    function getPriceB() public view returns (uint) {
        return (reserveA * 1e18) / reserveB;
    }

    // Get Reserves
    function getReserves() public view returns (uint, uint) {
        return (reserveA, reserveB);
    }

    function setLPToken(address _lpToken) public {
        require(lpToken == address(0), "Already set");
        lpToken = _lpToken;
    }
}
