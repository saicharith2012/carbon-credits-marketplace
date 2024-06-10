const GreenNFTData = artifacts.require("../contracts/GreenNFTData.sol");

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(GreenNFTData);
};
