// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDEX {
    function getReserves() external view returns (uint, uint);
    function swapAforB(uint amount) external;
    function swapBforA(uint amount) external;
}

interface IERC20 {
    function approve(address spender, uint amount) external returns (bool);
}

contract Arbitrage {

    function executeArbitrage(address dex1, address dex2, address tokenA, address tokenB, uint amount) public {

        // Get reserves
        (uint rA1, uint rB1) = IDEX(dex1).getReserves();
        (uint rA2, uint rB2) = IDEX(dex2).getReserves();

        // Prices
        uint price1 = (rB1 * 1e18) / rA1;
        uint price2 = (rB2 * 1e18) / rA2;

        // Approve both DEX
        IERC20(tokenA).approve(dex1, amount);
        IERC20(tokenA).approve(dex2, amount);
        IERC20(tokenB).approve(dex1, amount);
        IERC20(tokenB).approve(dex2, amount);

        if (price1 > price2) {
            // Buy cheap from dex2 → sell in dex1
            IDEX(dex2).swapAforB(amount);
            IDEX(dex1).swapBforA(amount);
        } else if (price2 > price1) {
            // Buy cheap from dex1 → sell in dex2
            IDEX(dex1).swapAforB(amount);
            IDEX(dex2).swapBforA(amount);
        } else {
            revert("No arbitrage opportunity");
        }
    }
}
