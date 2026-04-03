# blockchain-dex-hw3
TokenA - 0x80Ef107141Bb1a65d2AE39388C4aFb57fbbB4871
Tx Id -0x095602b4e10de5bd8cb915aa7673ea2092c5e5ffa1d126b999f25443f51625cf

Token B - 0x2Fba0e2023d1B50005f4f12081Fa88c4FB25A0D2
Tx Id - 0x006560d11c4ecb1b336b6c15b16f7264ddb10e847944cdf1c936b31939b65b62

LPToken - 0xe46cFfcd2620AA433127393E056Ae59649f6dB73
Tx Id - 0x87ac1ad6f18b1615c4eb2497ef094e708ef1d74e8fbe37fd1e06c2c9834ff6f0

Dex - 0x74A1c19574B7F6a8dAec656680C2F90B56da0ee7
Tx Id - 0xf3b15b2f08b35808be3bf0bd0dc9e39515fdadf9166faa58e018568225ad84c7

setDEX in LPToken 
Tx Id - 0x53a9ab5459dccb234749b9a2d19853a1e6591a9b52cc07c5e8680a78305f4ec5

Approved TKA(Dex1, 100000000000000000000000)
Tx Id - 0x4726210db58c314a596dbf278eb6d75d72469811893f18d1bf1417c3ae7dcb55

Approved TKB(Dex1, 100000000000000000000000)
Tx Id - 0x795263b7ffae29aa60c2edccc56401f29da61eefd5c4ee7ac7990a36014cc0be

in DEx - AddLiquidity(1000000000000000000000, 1000000000000000000000)
Tx Id - 0xe35164f3eb910b2b8fd37ded301f26e2bf2bf268ba4b45373a2db1138f288a12

approve(DEX1, 1000000000000000000)
0xf2316a4cc0b3be5ef19b50686edd67b3035cda6b7a6dc5d8ba5178191c3d5e6b

swapAforB(1000000000000000000)
0x0b39affc1001e6afc5d81845ae9db9ef54f519e965dda262f95aeff285421a56

LPToken2 - 0xD4307Ce16ecD2fDCC64434772F75bEAC9d17fc61
Tx Id - 0x57679f1b45f81afe4334dff3c7f249b53b629605fb41173118aa1741fe31eba9

Dex2 - 0x92E789DDF203b32F07bdfAc1d84B6A9Efb835156
Tx Id - 0xf0cefec85981ea5a92f62d44dcb92a1a50feb26d8219e1d646d84c21697e74e4

setDEX(DEX2)
Tx Id - 0xa56ee9844f9838a76b95f152ccf37500bed771c0e986cd81548643b3fd359333

TokenA
approve(DEX2, 100000000000000000000000)
Tx Id - 0x79ce2af15dc5a7b89992ac91772b20bed2c95a318448aa97764a0975cdb962d7

TokenB
approve(DEX2, 100000000000000000000000)
Tx Id - 0xe420e54d4b30b7c334bf3cbbcd6666756155140ee62521e3a9cfefee75a598c1

DEX2:
addLiquidity(1000000000000000000000, 1200000000000000000000)
Tx Id - 0x202d522788476d4810a20f21a0b154d17d9b0e8fd26451baf7ad8ea6c03f2e47

Arbitrage - 0x1cAa5e08Daf286FD30fD5984f3f403DA2c0C27Ce
Tx Id - 0x388d864934dbf3dd9ab1f3d1bccf8c0d355431688688e68995a8ae19d1d737d9

Fund Transfer ARBITRAGE : TokenA
transfer(arbitrage_address, 10000000000000000000)
Tx Id - 0x7ea01998e94559d149f4190fb767d99ecf0e9568c9d6ac4c66118afd4f623246

executeArbitrage(DEX1,  DEX2, TokenA, TokenB, 1000000000000000000)
Tx Id success- 0x4244f798b59cd7985241a831b9eafdd15b74636d2059233b2607829cd2d731be
Tx Id Failed - 0x9e7f5e294b97a6f093df5b6a763c094786e8f4560d46f5529efc707a2115ecde



How to Use

1. Connect MetaMask to Sepolia network
2. Use deployed contract addresses
3. Approve TokenA & TokenB for DEX
4. Add liquidity
5. Perform swaps
6. Execute arbitrage

---

## Arbitrage Logic

The arbitrage contract compares prices between two DEX pools using reserve ratios.  
If a price difference exists, it buys from the cheaper DEX and sells on the expensive one.

---

## Notes

- Arbitrage requires sufficient liquidity
- Large trades may fail due to slippage
- Profit depends on price difference between pools

A failed arbitrage scenario occurs when the price difference between the two DEX pools is insufficient to generate profit after accounting for trade size and slippage. 
In our implementation, executing arbitrage with a larger trade amount results in unfavorable price movement, causing the transaction to revert. This demonstrates that arbitrage is not always profitable and depends on liquidity and trade size.

