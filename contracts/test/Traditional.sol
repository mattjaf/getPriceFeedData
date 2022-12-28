// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @dev Provides a set of functions to operate with Chainlink's Price Feed contracts.
 * contract addresses can be found at https://docs.chain.link/data-feeds/price-feeds/addresses
 *
 */
library TraditionalPriceConverter {
    /**
     * @dev Method for externally calling the price feed contract and returning bytes data
     * @return extracted answer with set decimals
     *
     * Requirements:
     * - the answer can not equal 0
     *
     */
    function getPrice(address _contractAddress) internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(_contractAddress);
        unchecked {
            (, int256 answer, , , ) = priceFeed.latestRoundData();
            require(answer != 0, "value can not equal zero"); //added
            return uint256(answer * 1e10);
        }
    }

    /**
     * @dev Method for retrieving the current value of the token.
     * @param _tokenAmount is the amount of tokens to convert to the comparitive value.
     * @param _contractAddress is the address of the chainlink price feed contract address.
     * @param _decimalPlace is the amount of decimal postions returned in the answer.
     *
     * @notice Suggest this to be calculated to the 8th decimal place incase a token has a fractional value.
     *
     * Requirements:
     * - the calculation can not exceed the max value of uint256
     *
     *@return DISCLAIMER: it does not round up, instead it will truncate the value based on decimals
     *
     */

    function tokenToValue(
        uint256 _tokenAmount,
        address _contractAddress,
        uint8 _decimalPlace
    ) internal view returns (uint256) {
        uint256 price = getPrice(_contractAddress);
        require(price * (10**_decimalPlace) * _tokenAmount < type(uint256).max); //EVM will error before the custom error -- test
        unchecked {
            uint256 tokenAmountInComparitiveValue = (price * (10**_decimalPlace) * _tokenAmount) /
                1e18;
            return tokenAmountInComparitiveValue;
        }
    }

    /**
     * @dev Method for retrieving the amount of WEI equal to the provided value.
     * @param _comparitiveAmount is the comparitive value amount to get converted in to WEI.
     * @param _contractAddress is the address of the chainlink price feed contract address.
     * @param _decimalPlace is the decimal place of pricefeed data
     *
     * @notice Suggest this to be calculated to the 8th decimal place incase a token has a fractional value.
     *
     * Requirements:
     * - the calculation can not exceed the max value of uint256
     *
     *@return DISCLAIMER: the return result might be a fraction of a wei off due to truncation
     * might have + 1 wei
     *
     */
    function valueToWei(
        uint256 _comparitiveAmount,
        address _contractAddress,
        uint8 _decimalPlace
    ) internal view returns (uint256) {
        require(_comparitiveAmount * 1e18 * (10**_decimalPlace) < type(uint256).max); ////EVM will error before the custom error -- test
        unchecked {
            uint256 price = getPrice(_contractAddress);
            //require(price != 0, "can not divide by zero");
            uint256 valueInWei = (_comparitiveAmount * 1e18 * (10**_decimalPlace)) /
                ((price * (10**_decimalPlace)) / 1e18);
            return valueInWei;
        }
    }
}
