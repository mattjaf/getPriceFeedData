//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../GetPriceFeedDataV8.sol";
import "./Traditional.sol";

contract CallingContract {
    function GetPriceFeedDataV8TokenToValue(address _contractAddress)
        public
        view
        returns (uint256)
    {
        return GetPriceFeedDataV8.tokenToValue(1, _contractAddress, 8);
    }

    function GetPriceFeedDataV8ValueToWei(address _contractAddress) public view returns (uint256) {
        return GetPriceFeedDataV8.valueToWei(1, _contractAddress, 8);
    }

    function GetFlowValueToWei(
        uint256 _amount,
        address _contractAddress,
        uint8 _decimals
    ) public view returns (uint256) {
        return GetPriceFeedDataV8.valueToWei(_amount, _contractAddress, _decimals);
    }

    function GetFlowTokenToValue(
        uint256 _amount,
        address _contractAddress,
        uint8 _decimals
    ) public view returns (uint256) {
        return GetPriceFeedDataV8.tokenToValue(_amount, _contractAddress, _decimals);
    }

    function TraditionalTokenToValue(address _contractAddress) public view returns (uint256) {
        return TraditionalPriceConverter.tokenToValue(1, _contractAddress, 8);
    }

    function TraditionalValueToWei(address _contractAddress) public view returns (uint256) {
        return TraditionalPriceConverter.valueToWei(1, _contractAddress, 8);
    }
}
