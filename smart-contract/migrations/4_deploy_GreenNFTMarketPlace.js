const GreenNFTMarketPlace = artifacts.require("../../carbon-credits-marketplace/contracts/GreenNFTMarketPlace.sol");
const GreenNFTData = artifacts.require("../contracts/GreenNFTData.sol");
const CarbonCreditToken = artifacts.require("../contracts/CarbonCreditToken.sol");

const _greenNFTData = GreenNFTData.address;
const _carbonCreditToken = CarbonCreditToken.address;

module.exports = async function(deployer, network, accounts) {
    await deployer.deploy(GreenNFTMarketPlace, _greenNFTData, _carbonCreditToken);
};
