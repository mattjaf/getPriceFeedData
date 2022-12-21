//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * @dev Provides a set of functions to operate with Chainlink's Price Feed contracts.
 * contract addresses can be found at https://docs.chain.link/data-feeds/price-feeds/addresses
 *
 */
library GetPriceFeedDataV8 {

    /**
     * @dev Method for externally calling the price feed contract and extracting the answer casted to unit256
     * @return answer is the extracted answer
     *
     */
    function getPrice(address _contractAddress) internal view returns (uint256 answer) {
        unchecked {
            assembly {
                //store function selector
                mstore(0x00, 0xfeaf968c) // 0xfeaf968c
                let success := staticcall(gas(), _contractAddress, 28, 32, 0, 64) //<-- loading output to mem
                // failed
                if iszero(success) { 
                    revert(0, 0) 
                }
                //return
                answer := mload(32)
            }
        }
    }

    /**
     * @dev Method for retrieving the current value of the token.
     * @param _tokenAmount is the amount of tokens to convert to the comparitive value.
     * @param _contractAddress is the address of the chainlink price feed contract address.
     * @param _decimalPlace is the amount of decimal postions returned in the answer.
     *
     * Requirements:
     * - the calculation can not exceed the max value of uint256
     *
     *@return tokenAmountInComparitiveValue DISCLAIMER: it does not round up, instead it will truncate the value based on decimals
     *
     */
    function tokenToValue(
        uint256 _tokenAmount,
        address _contractAddress,
        uint8 _decimalPlace
    ) internal view returns (uint256 tokenAmountInComparitiveValue) {
        uint256 price = getPrice(_contractAddress) * 1e10;
        uint256 checkedAmount = price * (10**_decimalPlace) * _tokenAmount;
       // if (checkedAmount < type(uint256).max) { //EVM will error before the custom error -- test
        unchecked{
            tokenAmountInComparitiveValue = checkedAmount / 1e18;
            }
       // }
    }

    /**
     * @dev Method for retrieving the amount of WEI equal to the provided value.
     * @param _comparitiveAmount is the comparitive value amount to get converted in to WEI.
     * @param _contractAddress is the address of the chainlink price feed contract address.
     * @param _decimalPlace is the decimal place of pricefeed data
     *
     * @notice Suggest this to be calculated to the 8th decimal place incase a token has value less than a penny.
     *
     * Requirements:
     * - the calculation can not exceed the max value of uint256
     * - the calculation can not divide by zero
     *
     *@return valueInWei DISCLAIMER: the return result might be a fraction of a wei off due to truncation
     * might have + 1 wei
     *
     */
    function valueToWei(
        uint256 _comparitiveAmount,
        address _contractAddress,
        uint8 _decimalPlace
    ) internal view returns (uint256 valueInWei) {
        uint256 checkedAmount = _comparitiveAmount * 1e18 * (10**_decimalPlace);
        //if (checkedAmount < type(uint256).max) { ////EVM will error before the custom error -- test
        unchecked {
            uint256 price = getPrice(_contractAddress) * 1e10;
            //require(price != 0, "can not divide by zero"); // EVM already errors even in unchecked
            valueInWei = checkedAmount / ((price * (10**_decimalPlace)) / 1e18);
            }
       // } 
    }
}
