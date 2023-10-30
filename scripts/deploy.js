// import { formatEther, parseEther } from "viem";
// import hre from "hardhat";

async function main() {
  // Grab the contract factory
  const MyNFT = await ethers.getContractFactory("MyNFT");
  const signer = (await ethers.getSigners())[0]; // You can choose the signer you want to use

  const myNFT = await MyNFT.connect(signer).deploy();

  console.log("Contract deployed to address:", myNFT.target);
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
