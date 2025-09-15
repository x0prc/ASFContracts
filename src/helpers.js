const { ethers } = require("ethers");

function toWei(amount) {
  return ethers.utils.parseEther(amount.toString());
}

// Convert Wei values to ether string
function fromWei(amount) {
  return ethers.utils.formatEther(amount);
}

// Generate a random Ethereum address
function randomAddress() {
  const wallet = ethers.Wallet.createRandom();
  return wallet.address;
}

// Sleep (delay) utility for async scripting
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

// Fund an address with Ether from a signer 
async function fund(signer, to, amount) {
  const tx = {
    to,
    value: toWei(amount)
  };
  await signer.sendTransaction(tx);
}

module.exports = {
  toWei,
  fromWei,
  randomAddress,
  sleep,
  fund
};
