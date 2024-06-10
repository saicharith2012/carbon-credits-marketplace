// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";
import {Strings} from "./libraries/Strings.sol";

import {GreenNFTFactoryCommons} from "./commons/GreenNFTFactoryCommons.sol";
import {GreenNFT} from "./GreenNFT.sol";
import {GreenNFTMarketPlace} from "./GreenNFTMarketPlace.sol";
import {GreenNFTData} from "./GreenNFTData.sol";
import {CarbonCreditToken} from "./CarbonCreditToken.sol";

/**
 * @notice - This is the factory contract for a NFT of green
 */
contract GreenNFTFactory is Ownable, GreenNFTFactoryCommons {
    using SafeMath for uint256;
    using Strings for string;

    address GREEN_NFT_MARKETPLACE;

    GreenNFTMarketPlace public greenNFTMarketplace;
    GreenNFTData public greenNFTData;
    CarbonCreditToken public carbonCreditToken;

    // Events declaration
    event ProjectRegistered(
        uint indexed projectId,
        address indexed projectOwner
    );
    event ClaimRegistered(uint indexed claimId, address indexed claimant);
    event ClaimAudited(
        uint indexed projectId,
        uint indexed claimId,
        uint co2Reductions,
        string referenceDocument
    );
    event GreenNFTCreated(
        uint projectId,
        uint claimId,
        GreenNFT greenNFT,
        uint carbonCredits
    );

    constructor(
        GreenNFTMarketPlace _greenNFTMarketplace,
        GreenNFTData _greenNFTData,
        CarbonCreditToken _carbonCreditToken
    ) public {
        greenNFTMarketplace = _greenNFTMarketplace;
        greenNFTData = _greenNFTData;
        carbonCreditToken = _carbonCreditToken;

        GREEN_NFT_MARKETPLACE = address(greenNFTMarketplace);
    }

    /**
     * @notice - Throws if called by account without auditors
     */
    modifier onlyAuditor() {
        address auditor;
        address[] memory auditors = greenNFTData.getAuditors();
        for (uint i = 0; i < auditors.length; i++) {
            auditor = auditors[i];
        }

        require(msg.sender == auditor, "Caller should be the auditor");
        _;
    }

    /**
     * @notice - Register a auditor
     */
    function registerAuditor(address auditor) public returns (bool) {
        //function registerAuditor(address auditor) public onlyOwner returns (bool) {
        /// [Note]: Caller should be onlyOwner. But it is commentouted temporary.
        greenNFTData.addAuditor(auditor);
    }

    /**
     * @notice - Register a project and log the projectId
     */
    function registerProject(
        string memory projectName,
        uint co2Emissions
    ) public returns (uint) {
        address projectOwner = msg.sender;
        uint projectId = greenNFTData.saveProject(
            projectOwner,
            projectName,
            co2Emissions
        );
        emit ProjectRegistered(projectId, projectOwner); // Optional: Emit an event if you want to log this on the blockchain
        return projectId; // Return the project ID for use in the DApp
    }
    // /**
    //  * @notice - A project owner claim CO2 reductions
    //  */
    // function claimCO2Reductions(
    //     uint projectId,
    //     uint co2Reductions,
    //     uint startOfPeriod,
    //     uint endOfPeriod,
    //     string memory referenceDocument
    // ) public returns (bool) {
    //     /// Check whether a caller is a project owner or not
    //     GreenNFTData.Project memory project = greenNFTData.getProject(
    //         projectId
    //     );
    //     address _projectOwner = project.projectOwner;
    //     require(msg.sender == _projectOwner, "Caller must be a project owner");

    //     greenNFTData.saveClaim(
    //         projectId,
    //         co2Reductions,
    //         startOfPeriod,
    //         endOfPeriod,
    //         referenceDocument
    //     );
    // }

    /**
     * @notice - A project owner claims CO2 reductions and get a claim ID
     */
    function claimCO2Reductions(
        uint projectId,
        uint co2Reductions,
        uint startOfPeriod,
        uint endOfPeriod,
        string memory referenceDocument
    ) public returns (uint) {
        // Check whether a caller is a project owner or not
        GreenNFTData.Project memory project = greenNFTData.getProject(
            projectId
        );
        require(
            msg.sender == project.projectOwner,
            "Caller must be a project owner"
        );

        uint claimId = greenNFTData.saveClaim(
            projectId,
            co2Reductions,
            startOfPeriod,
            endOfPeriod,
            referenceDocument
        );
        emit ClaimRegistered(claimId, msg.sender); // Emit the event with claim ID and claimant
        return claimId; // Return the claim ID for use in the DApp
    }
    /**
     * @notice - An auditor audit a CO2 reduction claim
     * @notice - Only auditor can audit
     * @notice - mark it as audited
     */

    function auditClaim(
        uint claimId,
        string memory auditedReport
    ) public onlyAuditor returns (bool) {
        address auditor;
        address[] memory auditors = greenNFTData.getAuditors();
        for (uint i = 0; i < auditors.length; i++) {
            if (msg.sender == greenNFTData.getAuditor(i)) {
                auditor = greenNFTData.getAuditor(i);
            }
        }
        require(msg.sender == auditor, "Caller must be an auditor");

        GreenNFTData.Claim memory claim = greenNFTData.getClaim(claimId);
        uint _projectId = claim.projectId;
        uint _co2Reductions = claim.co2Reductions;
        string memory _referenceDocument = claim.referenceDocument;

        greenNFTData.markClaimAsAudited(claimId);
        emit ClaimAudited(
            _projectId,
            claimId,
            _co2Reductions,
            _referenceDocument
        );

        // Create a new GreenNFT
        _createNewGreenNFT(_projectId, claimId, _co2Reductions, auditedReport);
    }

    /**
     * @notice - Create a new GreenNFT
     */
    function _createNewGreenNFT(
        uint projectId,
        uint claimId,
        uint co2Reductions,
        string memory auditedReport
    ) internal returns (bool) {
        GreenNFTData.Project memory project = greenNFTData.getProject(
            projectId
        );
        address _projectOwner = project.projectOwner;
        string memory _projectName = project.projectName;
        string memory projectSymbol = "GREEN_NFT"; // [Note]: All NFT's symbol are common symbol
        string memory tokenURI = getTokenURI(auditedReport); // [Note]: IPFS hash + URL

        GreenNFT greenNFT = new GreenNFT(
            _projectOwner,
            _projectName,
            projectSymbol,
            tokenURI
        );

        // Calculate carbon credits
        uint carbonCredits = co2Reductions;

        emit GreenNFTCreated(projectId, claimId, greenNFT, carbonCredits);

        // The CarbonCreditTokens that is equal amount to given-carbonCredits are transferred into the wallet of project owner
        // [Note]: This contract should has some the CarbonCreditTokens balance.
        carbonCreditToken.transfer(_projectOwner, carbonCredits);
    }

    /**
     * @notice - Save a GreenNFT data
     */
    function saveGreenNFTData(
        uint claimId,
        GreenNFT greenNFT,
        address auditor,
        uint carbonCredits,
        string memory auditedReport
    ) public returns (bool) {
        GreenNFTData.Claim memory claim = greenNFTData.getClaim(claimId);
        uint _projectId = claim.projectId;
        uint _startOfPeriod = claim.startOfPeriod;
        uint _endOfPeriod = claim.endOfPeriod;
        uint _co2Reductions = claim.co2Reductions;

        GreenNFTData.Project memory project = greenNFTData.getProject(
            _projectId
        );

        // [Note]: Use a project instance as it is. (Do not assign another variable in order to avoid "stack too deep")
        _saveGreenNFTMetadata(
            _projectId,
            claimId,
            greenNFT,
            project.projectOwner,
            auditor,
            _startOfPeriod,
            _endOfPeriod,
            auditedReport
        );
        _saveGreenNFTEmissonData(
            project.co2Emissions,
            _co2Reductions,
            carbonCredits
        );
    }

    function _saveGreenNFTMetadata(
        uint projectId,
        uint claimId,
        GreenNFT greenNFT,
        address _projectOwner,
        address auditor,
        uint startOfPeriod,
        uint endOfPeriod,
        string memory auditedReport
    ) public returns (bool) {
        // Save metadata of a GreenNFT created
        greenNFTData.saveGreenNFTMetadata(
            projectId,
            claimId,
            greenNFT,
            _projectOwner,
            auditor,
            startOfPeriod,
            endOfPeriod,
            auditedReport
        );
    }

    function _saveGreenNFTEmissonData(
        // uint startOfPeriod,
        // uint endOfPeriod,
        uint co2Emissions,
        uint co2Reductions,
        uint carbonCredits
    ) public returns (bool) {
        /// Save emission data of a GreenNFT created
        greenNFTData.saveGreenNFTEmissonData(
            co2Emissions,
            co2Reductions,
            carbonCredits
        );
    }

    //-----------------
    // Getter methods
    //-----------------
    function baseTokenURI() public pure returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function getTokenURI(
        string memory _auditedReport
    ) public pure returns (string memory) {
        return Strings.strConcat(baseTokenURI(), _auditedReport); // IPFS hash of audited-report + base token URI
    }
}
