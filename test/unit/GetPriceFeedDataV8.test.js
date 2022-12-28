const { assert, expect } = require("chai")
const { network, deployments, ethers } = require("hardhat")
const { developmentChains } = require("../../helper-hardhat-config")

!developmentChains.includes(network.name)
    ? describe.skip
    : describe("CallingContract Unit Tests for `GetPriceFeedDataV8`", function () {
        /*ADDRESSES ON ETH-MAINNET FORK*/
        ETH_TO_USD = "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"
        MATIC_TO_USD = "0x7bAC85A8a13A4BcD8abb3eB7d6b4d632c5a57676"
        BTC_TO_USD = "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c"
        LINK_TO_USD = "0x2c1d072e956affc0d435cb7ac38ef18d24d9127c"
        AMP_TO_USD = "0x8797abc4641de76342b8ace9c63e3301dc35e3d8"
        SPELL_TO_USD = "0x8c110b94c5f1d347facf5e1e938ab2db60e3c9a8"

        MAX_UNIT256 = ethers.BigNumber.from("115792089237316195423570985008687907853269984665640564039457584007913129639935");

        beforeEach(async () => {
            accounts = await ethers.getSigners() // could also do with getNamedAccounts
            deployer = accounts[0]
            await deployments.fixture(["all"])
            CallingContract = await ethers.getContract("CallingContract")
            MockDataContract = await ethers.getContract("MockData")
            MockAddress = MockDataContract.address
            CallingContract = CallingContract.connect(deployer)
        })

        describe("checking libray functions", function () {
            it("ETH -- getConversionRate", async function () {
                const conversionRateUsdToWei = await CallingContract.GetPriceFeedDataV8ValueToWei(ETH_TO_USD)
                const conversionRateTokenToUsd = await CallingContract.GetPriceFeedDataV8TokenToValue(ETH_TO_USD)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("MATIC -- getConversionRate", async function () {
                const conversionRateUsdToWei = await CallingContract.GetPriceFeedDataV8ValueToWei(MATIC_TO_USD)
                const conversionRateTokenToUsd = await CallingContract.GetPriceFeedDataV8TokenToValue(MATIC_TO_USD)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("BTC -- getConversionRate", async function () {
                const conversionRateUsdToWei = await CallingContract.GetPriceFeedDataV8ValueToWei(BTC_TO_USD)
                const conversionRateTokenToUsd = await CallingContract.GetPriceFeedDataV8TokenToValue(BTC_TO_USD)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("LINK -- getConversionRate", async function () {
                const conversionRateUsdToWei = await CallingContract.GetPriceFeedDataV8ValueToWei(LINK_TO_USD)
                const conversionRateTokenToUsd = await CallingContract.GetPriceFeedDataV8TokenToValue(LINK_TO_USD)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("AMP -- getConversionRate", async function () {
                const conversionRateUsdToWei = await CallingContract.GetPriceFeedDataV8ValueToWei(AMP_TO_USD)
                const conversionRateTokenToUsd = await CallingContract.GetPriceFeedDataV8TokenToValue(AMP_TO_USD)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("SPELL -- getConversionRate", async function () {
                const conversionRateUsdToWei = await CallingContract.GetPriceFeedDataV8ValueToWei(SPELL_TO_USD)
                const conversionRateTokenToUsd = await CallingContract.GetPriceFeedDataV8TokenToValue(SPELL_TO_USD)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
        })
        describe("Reverts -- functions", function () {
        })
        it("MockRevert -- ValueToWei - ChainLink returns value zero", async function () {
            //const conversionRateUsdToWei = await CallingContract.GetPriceFeedDataV8ValueToWei(MockAddress)
            await expect(CallingContract.GetPriceFeedDataV8ValueToWei(MockAddress)).to.be.reverted;
        })
        it("MockRevert -- ValueToWei - too high of _decimalPlace (255)", async function () {
            await expect(CallingContract.GetFlowValueToWei(1, ETH_TO_USD, 255)).to.be.reverted;
        })
        it("MockRevert -- ValueToWei - too high of _decimalPace (100)", async function () {
            await expect(CallingContract.GetFlowValueToWei(1, ETH_TO_USD, 100)).to.be.reverted;
        })
        it("MockRevert -- ValueToWei - too high of _decimalPace (60)", async function () {
            await expect(CallingContract.GetFlowValueToWei(1, ETH_TO_USD, 60)).to.be.reverted;
        })
        it("MockRevert -- ValueToWei - too high of _decimalPace (59) && _comparitiveAmoun (2)", async function () {
            await expect(CallingContract.GetFlowValueToWei(2, ETH_TO_USD, 59)).to.be.reverted;
        })
        it("MockRevert -- ValueToWei - too high of _comparitiveAmoun (max uint256)", async function () {
            await expect(CallingContract.GetFlowValueToWei(MAX_UNIT256, ETH_TO_USD, 0)).to.be.reverted;
        })
        it("MockRevert -- TokenToValue - too high of _comparitiveAmount (max uint256)", async function () {
            await expect(CallingContract.GetFlowTokenToValue(MAX_UNIT256, ETH_TO_USD, 0)).to.be.reverted;
        })
        it("MockRevert -- TokenToValue - too high of _decimalPace (60)", async function () {
            await expect(CallingContract.GetFlowTokenToValue(1, ETH_TO_USD, 60)).to.be.reverted;
        })
    })


