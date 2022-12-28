//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract MockData {
    function latestRoundData()
        public
        pure
        returns (
            uint80,
            int256,
            uint256,
            uint256,
            uint80
        )
    {
        /* uint80 roundId = 36893488147419113466;//10
            int256 answer = 120036858718;//32
            uint256 startedAt = 1671226083;//32
            uint256 updatedAt = 1671226083;//32
            uint80 answeredInRound = 36893488147419113466;//10

            return (roundId, answer, startedAt, updatedAt, answeredInRound);*/
        //return (36893488147419113466, 120036858718, 1671226083, 1671226083, 36893488147419113466);
        return (36893488147419113466, 0, 1671226083, 1671226083, 36893488147419113466);
    }

    // "9a884bde": "get21()",
    function get21() external pure returns (uint256) {
        return 21;
    }
}
