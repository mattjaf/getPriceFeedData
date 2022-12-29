//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./MockFuzzData.sol";

// echidna-test /src/contracts/test/fuzzing/LibraryFuzzTest.sol --contract LibraryFuzzTest --config /src/contracts/test/fuzzing/config.yaml
// echidna-test /src/contracts/test/fuzzing/LibraryFuzzTest.sol --contract Test --config /src/contracts/test/fuzzing/config.yaml
contract LibraryFuzzTest is MockFuzzData {
    bool public equivalate = true;
    bool public check = true;

    function SetEquivalateValueToWei(
        uint256 _amount,
        //address _contractAddress,
        uint8 _decimals
    ) public {
        if (
            TraditionalValueToWei(_amount, address(this), _decimals) !=
            GetPriceFeedDataV8ValueToWei(_amount, address(this), _decimals)
        ) {
            equivalate = false;
        }
    }

    function SetEquivalateTokenToValue(
        uint256 _amount,
        //address _contractAddress,
        uint8 _decimals
    ) public {
        if (
            TraditionalTokenToValue(_amount, address(this), _decimals) !=
            GetPriceFeedDataV8TokenToValue(_amount, address(this), _decimals)
        ) {
            equivalate = false;
        }
    }

    function echidna_test_find_discrepancy() public view returns (bool) {
        return equivalate == true;
    }
}

contract Test {
    bool public revertCheck = true;
    bool public compareMockValueToWei = true;
    bool public compareMockTokenToValue = true;
    LibraryFuzzTest TestContract = new LibraryFuzzTest();

    function RevertComparisonBetweenTraditionalValueToWei(uint256 _amount, uint8 _decimals)
        public
    {
        // if ((_amount != 0 && _decimals != 0) && _amount < type(uint160).max && _decimals < 10) {
        try TestContract.TraditionalValueToWei(_amount, address(TestContract), _decimals) {
            revertCheck = true;
        } catch (bytes memory data) {
            try
                TestContract.GetPriceFeedDataV8ValueToWei(
                    _amount,
                    address(TestContract),
                    _decimals
                )
            {
                revertCheck = false;
            } catch (bytes memory data) {
                revertCheck = true;
            }
        }
        // }
    }

    function CompareWithMocksValueToWei(uint256 _comparitiveAmount, uint8 _decimalPlace) public {
        (, int256 answer, , , ) = TestContract.latestRoundData();
        uint256 price = uint256(answer) * 1e10;
        if (
            TestContract.GetPriceFeedDataV8ValueToWei(
                _comparitiveAmount,
                address(TestContract),
                _decimalPlace
            ) !=
            (_comparitiveAmount * 1e18 * (10**_decimalPlace)) /
                ((price * (10**_decimalPlace)) / 1e18)
        ) {
            compareMockValueToWei = false;
        }
    }

    function CompareWithMocksTokenToValue(uint256 _tokenAmount, uint8 _decimalPlace) public {
        (, int256 answer, , , ) = TestContract.latestRoundData();
        uint256 price = uint256(answer) * 1e10;
        if (
            TestContract.GetPriceFeedDataV8TokenToValue(
                _tokenAmount,
                address(TestContract),
                _decimalPlace
            ) != (price * (10**_decimalPlace) * _tokenAmount) / 1e18
        ) {
            compareMockTokenToValue = false;
        }
    }

    function echidna_test_find_discrepancyBetweenTraditionalReverts() public view returns (bool) {
        return revertCheck == true;
    }

    function echidna_test_find_discrepancyBetweenMockDataValueToWei() public view returns (bool) {
        return compareMockValueToWei == true;
    }

    function echidna_test_find_discrepancyBetweenMockDataTokenToValue()
        public
        view
        returns (bool)
    {
        return compareMockTokenToValue == true;
    }
}
