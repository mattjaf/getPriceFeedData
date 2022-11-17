//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Provides a set of functions to operate with Chainlink's Price Feed contracts.
 *
 */
library GetPriceFeedData {
    struct RoundData {
        uint80 roundId;
        int256 answer;
        uint256 startedAt;
        uint256 updatedAt;
        uint80 answeredInRound;
    }

    /**
     * @dev Method for externally calling the price feed contract and returning bytes data.
     *
     */
    function getPrice(address _contractAddress) internal view returns (bytes memory) {
        (, bytes memory bytesData) = _contractAddress.staticcall(
            abi.encodeWithSignature("latestRoundData()")
        );
        return bytesData;
    }

    /**
     * @dev Method for converting the bytes data into human readable a struct.
     *
     */
    function convert(bytes memory _priceFeedData) internal pure returns (RoundData memory) {
        RoundData memory structData = abi.decode(_priceFeedData, (RoundData));
        return structData;
    }

    /**
     * @dev Method for extracting the answer and setting the decimals.
     *
     */
    function extractAnswer(address _contractAddress) internal view returns (uint256) {
        bytes memory priceData = getPrice(_contractAddress);
        RoundData memory structData = convert(priceData);
        return uint256(structData.answer * 1e10);
    }

    /**
     * @dev Method for retrieving the current value of the a token in USD.
     * @param _tokenAmount is the amount of tokens to convert to USD.
     * @param _contractAddress is the address of the chainlink price feed contract address.
     * @param _decimalPlace is the amount of decimal postions returned in the answer.
     *
     */
    function getConversionRateTokenToUsd(
        uint256 _tokenAmount,
        address _contractAddress,
        uint256 _decimalPlace
    ) public view returns (uint256) {
        uint256 price = extractAnswer(_contractAddress);
        uint256 tokenAmountInUsd = (price * (10**_decimalPlace) * _tokenAmount) / 1e18;
        return tokenAmountInUsd;
    }

    /**
     * @dev Method for retrieving the amount of WEI equal to the provided USD value.
     * @param _usdAmount is the amount in USD to get converted in to WEI.
     * @param _contractAddress is the address of the chainlink price feed contract address.
     * @param _decimalPlace is the decimal place of pricefeed data
     *
     * @dev Suggest this to be calculated to the 8th decimal place incase a token has value less than a penny.
     *
     * DISCLAIMER: the return result might be a fraction of a wei off due to truncation
     * might have + 1 wei
     */
    function getConversionRateUsdToWei(
        uint256 _usdAmount,
        address _contractAddress,
        uint256 _decimalPlace
    ) public view returns (uint256) {
        uint256 price = extractAnswer(_contractAddress);
        uint256 usdToWei = (_usdAmount * 1e18 * (10**_decimalPlace)) /
            ((price * (10**_decimalPlace)) / 1e18);
        return usdToWei;
    }
}
