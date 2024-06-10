// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";
import {GreenNFTMarketplaceCommons} from "./commons/GreenNFTMarketPlaceCommons.sol";
import {GreenNFT} from "./GreenNFT.sol";
import {GreenNFTTradable} from "./GreenNFTTradable.sol";
import {GreenNFTData} from "./GreenNFTData.sol";
import {CarbonCreditToken} from "./CarbonCreditToken.sol";

contract GreenNFTMarketPlace is GreenNFTTradable, GreenNFTMarketplaceCommons {
    using SafeMath for uint256;

    uint256 unitPriceOfCarbonCredits = 1; // 1 ETH per 1 carbon credits

    address public GREEN_NFT_MARKETPLACE;

    GreenNFTData public greenNFTData;
    CarbonCreditToken public carbonCreditToken;

    constructor(
        GreenNFTData _greenNFTData,
        CarbonCreditToken _carbonCreditToken
    ) public GreenNFTTradable(_carbonCreditToken) {
        greenNFTData = _greenNFTData;
        carbonCreditToken = _carbonCreditToken;

        address(uint160(address(this)));
    }

    /**
     * @notice - Buy function that a buyer (msg.sender) purchases carbon credits from a seller.
     */
    function buyCarbonCredits(
        GreenNFT _greenNFT,
        uint256 orderOfCarbonCredits
    ) public payable returns (bool) {
        address buyer = msg.sender; // In advance, a buyer must transfer msg.value.

        // Check whether orderOfCarbonCredits is less than buyableCarbonCredits
        uint256 buyableCarbonCredits = getBuyableCarbonCredits(_greenNFT);
        require(
            orderOfCarbonCredits <= buyableCarbonCredits,
            "Order of carbon credits must be less than buyable carbon credits"
        );

        GreenNFTData.GreenNFTMetadata memory greenNFTMetadata = greenNFTData
            .getGreenNFTMetadataByNFTAddress(_greenNFT);
        uint256 _projectId = greenNFTData
            .getClaim(greenNFTMetadata.claimId)
            .projectId;
        address _seller = greenNFTData.getProject(_projectId).projectOwner;
        address payable seller = address(uint160(_seller)); // Convert owner address with payable

        // Calculate purchase amount (Unit price * buyable carbon credits)
        uint256 purchaseAmountOfCarbonCredits = getPurchaseAmountOfCarbonCredits(
                orderOfCarbonCredits
            );
        require(
            purchaseAmountOfCarbonCredits == msg.value,
            "Purchase amount of carbon credits must be equal to msg.value"
        );

        // ETH amount purchased is transferred from a buyer's wallet to the projectOwner's (seller's) wallet
        seller.transfer(purchaseAmountOfCarbonCredits);

        // CCTs (Carbon Credit Tokens) are transferred into the buyer's wallet address
        carbonCreditToken.transfer(buyer, purchaseAmountOfCarbonCredits);
        return true;
    }

    //--------------------------
    // Getter methods
    //--------------------------

    /**
     * @notice - Get buyable carbon credits
     */
    function getBuyableCarbonCredits(
        GreenNFT _greenNFT
    ) public view returns (uint256 _buyableCarbonCredits) {
        GreenNFTData.GreenNFTEmissonData
            memory greenNFTEmissonData = greenNFTData
                .getGreenNFTEmissonDataByNFTAddress(_greenNFT);
        return greenNFTEmissonData.buyableCarbonCredits;
    }

    /**
     * @notice - Calculate purchase amount (Unit price * order of carbon credits)
     */
    function getPurchaseAmountOfCarbonCredits(
        uint256 orderOfCarbonCredits
    ) public view returns (uint256 _purchaseAmountOfCarbonCredits) {
        uint256 purchaseAmountOfCarbonCredits = unitPriceOfCarbonCredits *
            orderOfCarbonCredits; // 1 ETH * order of carbon credits
        return purchaseAmountOfCarbonCredits;
    }
}
