const { assert, expect } = require("chai")
const { network, deployments, ethers } = require("hardhat")
const { developmentChains } = require("../../helper-hardhat-config")

!developmentChains.includes(network.name)
    ? describe.skip
    : describe("GetPriceFeedData Unit Tests", function () {
        ETH_TO_USD = "0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419"
        MATIC_TO_USD = "0x7bAC85A8a13A4BcD8abb3eB7d6b4d632c5a57676"
        BTC_TO_USD = "0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c"

        beforeEach(async () => {
            accounts = await ethers.getSigners() // could also do with getNamedAccounts
            deployer = accounts[0]
            await deployments.fixture(["all"])
            getPriceFeedDataContract = await ethers.getContract("GetPriceFeedData")
            getPriceFeedData = getPriceFeedDataContract.connect(deployer)
        })

        describe("checking libray functions", function () {
            it("getConversionRateTokenToUsd", async function () {
                const conversionRateUsdToWei = await getPriceFeedData.getConversionRateUsdToWei(1, ETH_TO_USD)
                const conversionRateTokenToUsd = await getPriceFeedData.getConversionRateTokenToUsd(1, ETH_TO_USD, 2)
                expect(conversionRateUsdToWei.mul(conversionRateTokenToUsd.div(100))).to.be.closeTo(ethers.utils.parseEther("1.0"), 1000000000000000)
            })
        })
    })


