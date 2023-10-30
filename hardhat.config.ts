import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox-viem";
require("dotenv").config();
require("@nomicfoundation/hardhat-ethers");
const { API_URL, PRIVATE_KEY } = process.env;

const config: HardhatUserConfig = {
  solidity: "0.8.20",
};

export default config;


module.exports = {
  solidity: "0.8.20",
  defaultNetwork: "elastos",
  networks: {
    hardhat: {},
    elastos: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
};