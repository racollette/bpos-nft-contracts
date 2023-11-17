require("dotenv/config");


async function main() {
  console.log(process.env.API_URL);
  console.log(process.env.PRIVATE_KEY);

  // const ownerAddress = "0x52B337a04dD35bc66d49018C09Bc70A35bCf7272"; // Replace with the owner's address
  // const paymentAddress = "0x52B337a04dD35bc66d49018C09Bc70A35bCf7272"; // Payment address

  // const nft1 = await ethers.getContractFactory("Proof_of_Work");
  // const NFT1 = await nft1.deploy(ownerAddress, paymentAddress, { gasPrice: 10000000000, gasLimit: 3000000 });
  // console.log("PoW Contract deployed to address:", NFT1.target);

  // const nft2 = await ethers.getContractFactory("Bonded_Proof_of_Stake");
  // const NFT2 = await nft2.deploy(ownerAddress, paymentAddress, { gasPrice: 10000000000, gasLimit: 3000000 });
  // console.log("BPoS Contract deployed to address:", NFT2.target);

  // const nft3 = await ethers.getContractFactory("Proof_of_Integrity");
  // const NFT3 = await nft3.deploy(ownerAddress, paymentAddress, { gasPrice: 10000000000, gasLimit: 3000000 });
  // console.log("PoI Contract deployed to address:", NFT3.target);

  const WELA_TOKEN = "0x517E9e5d46C1EA8aB6f78677d6114Ef47F71f6c4";
  const GLIDE_TOKEN = "0xd39eC832FF1CaaFAb2729c76dDeac967ABcA8F27";
  const START_BLOCK = 21686000;
  const ownerAddress = "0x52B337a04dD35bc66d49018C09Bc70A35bCf7272"; // Replace with the owner's address

  const powRewards = await ethers.getContractFactory("TokenRewards");
  const PoWRewards = await powRewards.deploy(GLIDE_TOKEN, START_BLOCK, ownerAddress, { gasPrice: 10000000000, gasLimit: 3000000 });
  console.log("PoW Rewards contract deployed to address:", PoWRewards.target);

  const ecRewards = await ethers.getContractFactory("TokenRewards");
  const ECRewards = await ecRewards.deploy(WELA_TOKEN, START_BLOCK, ownerAddress, { gasPrice: 10000000000, gasLimit: 3000000 });
  console.log("EC Rewards contract deployed to address:", ECRewards.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
