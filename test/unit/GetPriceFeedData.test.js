const { assert, expect } = require("chai")
const { network, deployments, ethers } = require("hardhat")
const { developmentChains } = require("../../helper-hardhat-config")

!developmentChains.includes(network.name)
    ? describe.skip
    : describe("GetPriceFeedData Unit Tests", function () {
        /*ADDRESSES ON ETH-MAINNET FORK*/
        ETH_TO_USD = "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"
        MATIC_TO_USD = "0x7bAC85A8a13A4BcD8abb3eB7d6b4d632c5a57676"
        BTC_TO_USD = "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c"
        LINK_TO_USD = "0x2c1d072e956affc0d435cb7ac38ef18d24d9127c"
        AMP_TO_USD = "0x8797abc4641de76342b8ace9c63e3301dc35e3d8"
        SPELL_TO_USD = "0x8c110b94c5f1d347facf5e1e938ab2db60e3c9a8"

        beforeEach(async () => {
            accounts = await ethers.getSigners() // could also do with getNamedAccounts
            deployer = accounts[0]
            await deployments.fixture(["all"])
            getPriceFeedDataContract = await ethers.getContract("GetPriceFeedData")
            getPriceFeedData = getPriceFeedDataContract.connect(deployer)
        })

        describe("checking libray functions", function () {
            it("ETH -- getConversionRate", async function () {
                const conversionRateUsdToWei = await getPriceFeedData.getConversionRateUsdToWei(1, ETH_TO_USD, 8)
                const conversionRateTokenToUsd = await getPriceFeedData.getConversionRateTokenToUsd(1, ETH_TO_USD, 8)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("MATIC -- getConversionRate", async function () {
                const conversionRateUsdToWei = await getPriceFeedData.getConversionRateUsdToWei(1, MATIC_TO_USD, 8)
                const conversionRateTokenToUsd = await getPriceFeedData.getConversionRateTokenToUsd(1, MATIC_TO_USD, 8)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("BTC -- getConversionRate", async function () {
                const conversionRateUsdToWei = await getPriceFeedData.getConversionRateUsdToWei(1, BTC_TO_USD, 8)
                const conversionRateTokenToUsd = await getPriceFeedData.getConversionRateTokenToUsd(1, BTC_TO_USD, 8)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("LINK -- getConversionRate", async function () {
                const conversionRateUsdToWei = await getPriceFeedData.getConversionRateUsdToWei(1, LINK_TO_USD, 8)
                const conversionRateTokenToUsd = await getPriceFeedData.getConversionRateTokenToUsd(1, LINK_TO_USD, 8)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("AMP -- getConversionRate", async function () {
                const conversionRateUsdToWei = await getPriceFeedData.getConversionRateUsdToWei(1, AMP_TO_USD, 8)
                const conversionRateTokenToUsd = await getPriceFeedData.getConversionRateTokenToUsd(1, AMP_TO_USD, 8)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
            it("SPELL -- getConversionRate", async function () {
                const conversionRateUsdToWei = await getPriceFeedData.getConversionRateUsdToWei(1, SPELL_TO_USD, 8)
                const conversionRateTokenToUsd = await getPriceFeedData.getConversionRateTokenToUsd(1, SPELL_TO_USD, 8)
                const deviation = ethers.BigNumber.from(conversionRateTokenToUsd).div(1e8).toNumber() + 1
                /* there might be a + 1 wei off due to truncation*/
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd).div(1e8)).to.be.closeTo(ethers.utils.parseEther("1.0"), deviation)
            })
        })
    })


