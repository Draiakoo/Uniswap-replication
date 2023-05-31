// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

library Position{
    struct Info{
        uint128 liquidity;
    }

    function get(mapping(bytes32 => Position.Info) storage self, address owner, int24 lowerTick, int24 upperTick) internal view returns(Position.Info storage){
        bytes32 key = keccak256(abi.encodePacked(owner, lowerTick, upperTick));
        return self[key];
    }

    function update(Info storage self, uint128 liquidityDelta) internal {
        uint128 liquidityBefore = self.liquidity;
        uint128 liquidityAfter = liquidityBefore + liquidityDelta;
        self.liquidity = liquidityAfter;
    }
}