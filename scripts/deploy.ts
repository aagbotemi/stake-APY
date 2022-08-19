import { ethers } from "hardhat";

require("dotenv").config();

type BytesLike = any;

async function main() {
  let [owner, user1, user2, user3, user4, user5] = await ethers.getSigners();

  const Stake = await ethers.getContractFactory("Stake");
  const stake = await Stake.deploy();

  await stake.deployed();

  console.log(
    "Staking contract deployed to this address",
    stake.address);




  // let provider = {
  //   PrivateKey: process.env.PRIVATE_KEY as BytesLike,
  //   URL: process.env.ROPSTEN_URL,
  // };
  // const provider2 = ethers.getDefaultProvider("ropsten", provider.URL);
  
  // let wallet = new ethers.Wallet(provider.PrivateKey, provider2);


  // await wallet.sendTransaction({ to: stake.address, value: "0.1" });


  // -> the time limit was set to 2 seconds
  const stakeTxn = await stake.stake(1, { value: ethers.utils.parseEther("0.01") });
  const stakeTxnReciept = await stakeTxn.wait();
  console.log("Create Stake Log: ", stakeTxnReciept);


  // -> the time limit was set to 2 seconds
  const contractBalanceTxn = await stake.contractBalance();
  console.log("Stake Contract Balance 1 Log: ", contractBalanceTxn);


  setTimeout(async () => {
    const withdrawTxn = await stake.withdrawStake();
    const withdrawTxnReciept = await withdrawTxn.wait();
    console.log("Withdraw Stake Log: ", withdrawTxnReciept);

    // -> the time limit was set to 2 seconds
    const contractBalanceTxn2 = await stake.contractBalance();
    console.log("Stake Contract Balance 2 Log: ", contractBalanceTxn2);
  }, 2000)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
