//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../GetPriceFeedDataV8.sol";
import "./Traditional.sol";

contract GasTest {
    function GetPriceFeedDataV8TokenToValue(address _contractAddress) public {
        GetPriceFeedDataV8.tokenToValue(1, _contractAddress, 8);
    }

    function GetPriceFeedDataV8ValueToWei(address _contractAddress) public {
        GetPriceFeedDataV8.valueToWei(1, _contractAddress, 8);
    }

    function TraditionalTokenToValue(address _contractAddress) public {
        TraditionalPriceConverter.tokenToValue(1, _contractAddress, 8);
    }

    function TraditionalValueToWei(address _contractAddress) public {
        TraditionalPriceConverter.valueToWei(1, _contractAddress, 8);
    }
}
