const { assert, expect } = require("chai")
const { network, deployments, ethers } = require("hardhat")
const { developmentChains } = require("../../helper-hardhat-config")

!developmentChains.includes(network.name)
    ? describe.skip
    : describe("Gas Comparison Test", function () {
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
            GasTestContract = await ethers.getContract("GasTest")
            GasTest = GasTestContract.connect(deployer)
        })

        describe("checking libray's functions", function () {
            it("Compares Gas Cost -- TokenToWei", async function () {
                const GetPriceFeedDataV8TokenToWei = await GasTest.GetPriceFeedDataV8ValueToWei(ETH_TO_USD)
                const receipt = await GetPriceFeedDataV8TokenToWei.wait()
                const gasUsed = receipt.gasUsed;
                const TraditionalValueToWei = await GasTest.TraditionalValueToWei(ETH_TO_USD)
                const receiptTraditional = await TraditionalValueToWei.wait()
                const gasUsedTraditional = receiptTraditional.gasUsed;
                expect(gasUsedTraditional > gasUsed).to.be.equal(
                    true)
                console.log(`Library: ${+ethers.BigNumber.from(gasUsed).toString()} gwei`, "<", `Traditional: ${+ethers.BigNumber.from(gasUsedTraditional).toString()} gwei`)
            })
            it("Compares Gas Cost -- TokenToValue", async function () {
                const GetPriceFeedDataV8TokenToValue = await GasTest.GetPriceFeedDataV8TokenToValue(ETH_TO_USD)
                const receipt = await GetPriceFeedDataV8TokenToValue.wait()
                const gasUsed = receipt.gasUsed;
                const TraditionalTokenToValue = await GasTest.TraditionalTokenToValue(ETH_TO_USD)
                const receiptTraditional = await TraditionalTokenToValue.wait()
                const gasUsedTraditional = receiptTraditional.gasUsed;
                expect(gasUsedTraditional > gasUsed).to.be.equal(
                    true)
                console.log(`library: ${+ethers.BigNumber.from(gasUsed).toString()} gwei`, "<", `Traditional: ${+ethers.BigNumber.from(gasUsedTraditional).toString()} gwei`)
            })
        })
    })


