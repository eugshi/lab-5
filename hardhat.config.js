/**
 * @type import('hardhat/config').HardhatUserConfig
 */
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();
module.exports = {
  solidity: "0.8.8",
  networks: {
    goerli: {
      chainId: 5,
      url: process.env.GOERLI_APIURL,
      accounts: {
        mnemonic: process.env.GOERLI_MNEMONIC,
      },
    },
  },
};
