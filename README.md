## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [Nodejs](https://nodejs.org/en/)
  - You'll know you've installed nodejs right if you can run:
    - `node --version` and get an ouput like: `vx.x.x`
- [Yarn](https://classic.yarnpkg.com/lang/en/docs/install/) instead of `npm`
  - You'll know you've installed yarn right if you can run:
    - `yarn --version` and get an output like: `x.x.x`
    - You might need to install it with `npm`

## Quickstart

```
git clone https://github.com/mattjaf/getPriceFeedData.git
cd getPriceFeedData
yarn
```

### Optional Gitpod

If you can't or don't want to run and install locally, you can work with this repo in Gitpod. If you do this, you can skip the `clone this repo` part.

# Deployment to a testnet or mainnet

1. Setup environment variabltes

You'll want to set your `MUMBAI_RPC_URL` and `PRIVATE_KEY` as environment variables. You can add them to a `.env` file, similar to what you see in `.env.example`.

- `PRIVATE_KEY`: The private key of your account (like from [metamask](https://metamask.io/)). **NOTE:** FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT.
  - You can [learn how to export it here](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key).
- `MUMBAI_RPC_URL`: This is url of the polygon mumbai testnet node you're working with. You can get setup with one for free from [Alchemy](https://alchemy.com/?a=673c802981)

If you want to auto verify it on polyscan, you'll want to set you `POLYSCAN_API_KEY`
- `POLYSCAN_API_KEY`: This is allows you to interact with the polyscan API. You can get setup with one for free from [polyscan](https://polygonscan.com/login?cmd=last)

DISCLAIMER: If you dont want to verify the contract, you can leave it blank or set `VERIFY` to false

2. Get testnet mumbai

Head over to [faucets.polygon.technology](https://faucet.polygon.technology/) and get some tesnet MATIC. You should see the MATIC show up in your metamask.
  - They also have a faucet built into the polygon discord channel[polygon discord invite](https://discord.gg/RZPruHJe) It is located under support
  - you can also ask me @mattjaf#1211 and I can possibly send a substantial amount

3. Deploy to localhost

```
yarn hardhat deploy
```


# Usage

deploy to testnet
```
yarn hardhat deploy --network networkName
```
such as,
```
yarn hardhat deploy --network mumbai
```



supported networks in hardhat.config.js include, but limited to:

localhost, sepolia, rinkeby, kovan, mainnet, polygon, mumbai



## Testing

```
yarn hardhat test
```

```
yarn coverage
```
