// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./ERC20Mintable.sol";
import "../src/UniswapV3Pool.sol";

contract CounterTest is Test {
    ERC20Mintable token0;
    ERC20Mintable token1;
    UniswapV3Pool pool;

    struct TestCaseParams {
        uint256 wethBalance;
        uint256 usdcBalance;
        int24 currentTick;
        int24 lowerTick;
        int24 upperTick;
        uint128 liquidity;
        uint160 currentSqrtP;
        bool transferInMintCallback;
        bool transferInSwapCallback;
        bool mintLiqudity;
    }

    function setUp() public {
        token0 = new ERC20Mintable("Ether", "ETH");
        token1 = new ERC20Mintable("USDC", "USDC");
    }

    function testMintSucces() public {
        TestCaseParams memory params = TestCaseParams({
            wethBalance: 1 ether,
            usdcBalance: 5000 ether,
            currentTick: 85176,
            lowerTick: 84222,
            upperTick: 86129,
            liquidity: 1517882343751509868544,
            currentSqrtP: 5602277097478614198912276234240,
            transferInMintCallback: true,
            transferInSwapCallback: true,
            mintLiquidity: true
        });
    }

    ///////////////////////////////// Helper Functions ///////////////////////

    function setupTestCase(TestCaseParams memory params) internal returns(uint256, uint256){
        token0.mint(address(this), params.wethBalance);
        token1.mint(address(this), params.usdcBalance);

        pool = new UniswapV3Pool(address(token0), address(token1), params.currentSqrtP, params.currentSqrtP);

        if(params.mintLiqudity){
            (uint256 poolBalance0, uint256 poolBalance1) = pool.mint(address(this), params.lowerTick, params.upperTick, params.liquidity);

        }

        return(poolBalance0, poolBalance1);
    }
}
