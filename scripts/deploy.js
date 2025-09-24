require("dotenv").config();
const { ethers } = require("ethers");
const fs = require("fs");

async function main() {
    const contractJson = JSON.parse(fs.readFileSync("./out/SimpleBank.sol/SimpleBank.json", "utf-8"));
    const abi = contractJson.abi;
    const bytecode = contractJson.bytecode.object;

    // Connect to the network
    const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);

    // Get your wallet
    const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

    // Create contract factory
    const factory = new ethers.ContractFactory(abi, bytecode, wallet);

    // Deploy contract
    const contract = await factory.deploy();
    await contract.deployed();

    console.log("SimpleBank deployed to:", contract.address);
}

main().catch((err) => {
    console.error(err);
    process.exit(1);
});
