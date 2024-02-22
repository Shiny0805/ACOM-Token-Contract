const { ethers } = require("hardhat");
const { txHash } = require("./deploy/test");

async function main() {

    const [deployer] = await ethers.getSigners();
    const deployerAddress = await deployer.getAddress();
    const message0 = 'Deploying ACOM with address: ' + deployerAddress;
    console.log(message0);
    //////////////////////////////////////////////////////////////////////

    const TOKENFACTORY = await ethers.getContractFactory('ACOM');
    // const tokenFactory = await TOKENFACTORY.deploy("0x894c488FeC80f42c3ed2C5d2E5Bf405fDD5f76D8");
    const tokenFactory = await TOKENFACTORY.deploy();
    await tokenFactory.deployed();
    const tokenFactoryAddress = tokenFactory.address;
    console.log(txHash);
    console.log('Token contract deployed at', tokenFactoryAddress);
  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
  