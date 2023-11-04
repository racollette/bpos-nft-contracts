// import { formatEther, parseEther } from "viem";
// import hre from "hardhat";
require("dotenv/config");

async function main() {
  console.log(process.env.API_URL);
  console.log(process.env.PRIVATE_KEY);
  // Grab the contract factory
  // const signer = (await ethers.getSigners())[0]; // You can choose the signer you want to use

  // console.log(MyNFT);

  const nft1 = await ethers.getContractFactory("Proof_of_Work");
  const NFT1 = await nft1.deploy("0x3Ac3935326cCA3146365a39458b5905bCdAe476b", { gasPrice: 10000000000, gasLimit: 3000000 });
  console.log("PoW Contract deployed to address:", NFT1.target);

  const nft2 = await ethers.getContractFactory("Bonded_Proof_of_Stake");
  const NFT2 = await nft2.deploy("0x3Ac3935326cCA3146365a39458b5905bCdAe476b", { gasPrice: 10000000000, gasLimit: 3000000 });
  console.log("BPoS Contract deployed to address:", NFT2.target);

  const nft3 = await ethers.getContractFactory("Proof_of_Integrity");
  const NFT3 = await nft3.deploy("0x3Ac3935326cCA3146365a39458b5905bCdAe476b", { gasPrice: 10000000000, gasLimit: 3000000 });
  console.log("PoI Contract deployed to address:", NFT3.target);

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

// async function main() {
//   const currentTimestampInSeconds = Math.round(Date.now() / 1000);
//   const unlockTime = BigInt(currentTimestampInSeconds + 60);

//   const lockedAmount = parseEther("0.001");

//   const lock = await hre.viem.deployContract("Lock", [unlockTime], {
//     value: lockedAmount,
//   });

//   console.log(
//     `Lock with ${formatEther(
//       lockedAmount
//     )}ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`
//   );
// }

// // We recommend this pattern to be able to use async/await everywhere
// // and properly handle errors.
// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });
