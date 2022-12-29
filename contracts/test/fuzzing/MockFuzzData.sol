//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../../GetPriceFeedDataV8.sol";
import "../Traditional.sol";

contract MockFuzzData {
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
        return (36893488147419113466, 120036858718, 1671226083, 1671226083, 36893488147419113466);
    }

    function GetPriceFeedDataV8TokenToValue(
        uint256 _amount,
        address _contractAddress,
        uint8 _decimals
    ) public view returns (uint256) {
        return GetPriceFeedDataV8.tokenToValue(_amount, _contractAddress, _decimals);
    }

    function GetPriceFeedDataV8ValueToWei(
        uint256 _amount,
        address _contractAddress,
        uint8 _decimals
    ) public view returns (uint256) {
        return GetPriceFeedDataV8.valueToWei(_amount, _contractAddress, _decimals);
    }

    function TraditionalTokenToValue(
        uint256 _amount,
        address _contractAddress,
        uint8 _decimals
    ) public view returns (uint256) {
        return TraditionalPriceConverter.tokenToValue(_amount, _contractAddress, _decimals);
    }

    function TraditionalValueToWei(
        uint256 _amount,
        address _contractAddress,
        uint8 _decimals
    ) public view returns (uint256) {
        return TraditionalPriceConverter.valueToWei(_amount, _contractAddress, _decimals);
    }
}
