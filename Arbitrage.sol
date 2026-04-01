// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IDEX {
    function getReserves() external view returns (uint, uint);
    function swapAforB(uint amount) external;
    function swapBforA(uint amount) external;
}

contract Arbitrage {

    function executeArbitrage(address dex1, address dex2, uint amount) public {

        (uint rA1, uint rB1) = IDEX(dex1).getReserves();
        (uint rA2, uint rB2) = IDEX(dex2).getReserves();

        uint price1 = (rB1 * 1e18) / rA1;
        uint price2 = (rB2 * 1e18) / rA2;

        if (price1 > price2) {
            // Buy from dex2 (cheap), sell in dex1 (expensive)
            IDEX(dex2).swapAforB(amount);
            IDEX(dex1).swapBforA(amount);
        } else if (price2 > price1) {
            // Buy from dex1, sell in dex2
            IDEX(dex1).swapAforB(amount);
            IDEX(dex2).swapBforA(amount);
        }
    }
}
