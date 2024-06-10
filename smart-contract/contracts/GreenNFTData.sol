// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";
import {GreenNFTDataCommons} from "./commons/GreenNFTDataCommons.sol";
import {GreenNFT} from "./GreenNFT.sol";

/**
 * @notice - This is the storage contract for GreenNFTs
 */
/**
 * @notice - Get all claims that have not been audited yet
 * @return Claim[] memory - An array of all unaudited claims
 */
function getUnauditedClaims() public view returns (Claim[] memory) {
    // Implementation details omitted
}

/**
 * @notice - Get all claims
 */
function getAllClaims() public view returns (Claim[] memory) {
    // Implementation details omitted
}

/**
 * @notice - Save metadata of a GreenNFT
 */
function saveGreenNFTMetadata(
    uint _projectId,
    uint _claimId,
    GreenNFT _greenNFT
) {
    // Implementation details omitted
}
/**
 * @notice - Get all claims that have not been audited yet
 * @return Claim[] memory - An array of all unaudited claims
 */
function getUnauditedClaims() public view returns (Claim[] memory) {
    // Implementation details omitted
}

/**
 * @notice - Get all claims
 */
function getAllClaims() public view returns (Claim[] memory) {
    // Implementation details omitted
}

/**
 * @notice - Save metadata of a GreenNFT
 */
function saveGreenNFTMetadata(
    uint _projectId,
    uint _claimId,
    GreenNFT _greenNFT
) {
    // Implementation details omitted
}
/**
 * @notice - Get all claims that have not been audited yet
 * @return Claim[] memory - An array of all unaudited claims
 */
function getUnauditedClaims() public view returns (Claim[] memory) {
    // Implementation details omitted
}

/**
 * @notice - Get all claims
 */
function getAllClaims() public view returns (Claim[] memory) {
    // Implementation details omitted
}

/**
 * @notice - Save metadata of a GreenNFT
 */
function saveGreenNFTMetadata(
    uint _projectId,
    uint _claimId,
    GreenNFT _greenNFT
) {
    // Implementation details omitted
}
contract GreenNFTData is GreenNFTDataCommons {
    using SafeMath for uint;

    uint currentProjectId;
    uint currentClaimId;
    uint currentGreenNFTMetadataId;

    // Auditor
    address[] public auditors;

    // All GreenNFTs addresses
    address[] public greenNFTAddresses;

    mapping(address => GreenNFTMetadata) public greenNFTMetadatasByAddress;
    mapping(address => GreenNFTEmissonData) public greenNFTEmissonDataByAddress;

    // Events
    event GreenNFTStatusUpdated(
        address indexed greenNFT,
        GreenNFTStatus newStatus
    );

    event GreenNFTEmissonDataUpdated(
        address indexed greenNFT,
        uint256 buyableCarbonCredits
    );

    constructor() public {}

    /**
     * @notice - Register a auditor
     */
    function addAuditor(address auditor) public returns (bool) {
        auditors.push(auditor);
    }

    /**
     * @notice - Save a project and return the projectId
     */
    function saveProject(
        address _projectOwner,
        string memory _projectName,
        uint _co2Emissions
    ) public returns (uint) {
        currentProjectId++;
        Project memory project = Project({
            projectOwner: _projectOwner,
            projectName: _projectName,
            co2Emissions: _co2Emissions
        });
        projects.push(project);
        return currentProjectId; // Return the new project ID after incrementing
    }

    /**
     * @notice - Save a CO2 reduction claim and return the claimId
     */
    function saveClaim(
        uint _projectId,
        uint _co2Reductions,
        uint _startOfPeriod,
        uint _endOfPeriod,
        string memory _referenceDocument
    ) public returns (uint) {
        currentClaimId++;
        Claim memory claim = Claim({
            projectId: _projectId,
            co2Reductions: _co2Reductions,
            startOfPeriod: _startOfPeriod,
            endOfPeriod: _endOfPeriod,
            referenceDocument: _referenceDocument,
            audited: false // initially false
        });
        claims.push(claim);
        return currentClaimId; // Return the new claim ID after incrementing
    }

    /**
     * @notice - Mark a claim as audited
     */
    function markClaimAsAudited(uint _claimId) public returns (bool) {
        uint index = _claimId.sub(1);
        Claim storage claim = claims[index];
        claim.audited = true;
        return true;
    }

    /**
     * @notice - Get all unaudited claims
     */
/**
 * @notice - Get all claims that have not been audited yet
 * @return Claim[] memory - An array of all unaudited claims
 */
/**
     * @notice - Get all claims that have not been audited yet
     * @return Claim[] memory - An array of all unaudited claims
/**
      * @notice - Get all claims that have not been audited yet
/**
       * @notice - Get all claims that have not been audited yet
       
            * @return Claim[] memory - An array of all unaudited claims
      
          */
        function getUnauditedClaims() public view returns (Claim[] memory) {
        uint unauditedCount;
        for (uint i = 0; i < claims.length; i++) {
            if (!claims[i].audited) {
                unauditedCount++;
            }
        }

        Claim[] memory unauditedClaims = new Claim[](unauditedCount);
        uint index;
        for (uint i = 0; i < claims.length; i++) {
            if (!claims[i].audited) {
                unauditedClaims[index] = claims[i];
                index++;
            }
        }

        return unauditedClaims;
    }

    /**
     * @notice - Get all claims
     */
    function getAllClaims() public view returns (Claim[] memory) {
        return claims;
    }

    /**
     * @notice - Save metadata of a GreenNFT
     */
    function saveGreenNFTMetadata(
        uint _projectId,
        uint _claimId,
        GreenNFT _greenNFT,
        address _projectOwner,
        address _auditor,
        uint _startOfPeriod,
        uint _endOfPeriod,
        string memory _auditedReport
    ) public returns (bool) {
        currentGreenNFTMetadataId++;

        // Save metadata of a GreenNFT
        GreenNFTMetadata memory greenNFTMetadata = GreenNFTMetadata({
            projectId: _projectId,
            claimId: _claimId,
            greenNFT: _greenNFT,
            projectOwner: _projectOwner,
            auditor: _auditor,
            timestampOfissuedDate: now,
            startOfPeriod: _startOfPeriod,
            endOfPeriod: _endOfPeriod,
            auditedReport: _auditedReport,
            greenNFTStatus: GreenNFTStatus.Audited
        });
        greenNFTMetadatas.push(greenNFTMetadata);

        // Update GreenNFTs addresses
        greenNFTAddresses.push(address(_greenNFT));
    }

    // function updateBuyableCarbonCredits(
    //     address greenNFTAddress,
    //     uint256 orderOfCarbonCredits
    // ) external onlyOwner {
    //     GreenNFTEmissonData storage emissionData = greenNFTEmissonDataByAddress[
    //         greenNFTAddress
    //     ];
    //     require(
    //         emissionData.buyableCarbonCredits >= orderOfCarbonCredits,
    //         "Insufficient buyable carbon credits"
    //     );

    //     emissionData.buyableCarbonCredits = emissionData
    //         .buyableCarbonCredits
    //         .sub(orderOfCarbonCredits);

    //     emit GreenNFTEmissonDataUpdated(
    //         greenNFTAddress,
    //         emissionData.buyableCarbonCredits
    //     );
    // }

    /**
     * @notice - Save emission data of a GreenNFT
     */
    function saveGreenNFTEmissonData(
        uint _co2Emissions,
        uint _co2Reductions,
        uint _carbonCredits
    ) public returns (bool) {
        // Save emission data of a GreenNFT
        GreenNFTEmissonData memory greenNFTEmissonData = GreenNFTEmissonData({
            co2Emissions: _co2Emissions,
            co2Reductions: _co2Reductions,
            carbonCredits: _carbonCredits,
            buyableCarbonCredits: _carbonCredits // [Note]: Initially, carbonCredits and buyableCarbonCredits are equal amount
        });
        greenNFTEmissonDatas.push(greenNFTEmissonData);
    }

    /**
     * @notice Update status ("Sale" or "NotSale")
     */
    function updateStatus(
        GreenNFT _greenNFT,
        GreenNFTStatus _newStatus
    ) public returns (bool) {
        // Identify the greenNFT's index
        uint greenNFTMetadataIndex = getGreenNFTMetadataIndex(_greenNFT);

        // Update the metadata of a GreenNFT
        GreenNFTMetadata storage greenNFTMetadata = greenNFTMetadatas[
            greenNFTMetadataIndex
        ];
        greenNFTMetadata.greenNFTStatus = _newStatus;

        emit GreenNFTStatusUpdated(address(_greenNFT), _newStatus); // Emit an event to indicate status change

        return true;
    }
    //-----------------
    // Getter methods
    //-----------------

    function getProject(
        uint projectId
    ) public view returns (Project memory _projectId) {
        uint index = projectId.sub(1);
        Project memory project = projects[index];
        return project;
    }

    function getClaim(uint claimId) public view returns (Claim memory _claim) {
        uint index = claimId.sub(1);
        Claim memory claim = claims[index];
        return claim;
    }

    function getGreenNFTMetadata(
        uint greenNFTMetadataId
    ) public view returns (GreenNFTMetadata memory _greenNFTMetadata) {
        uint index = greenNFTMetadataId.sub(1);
        GreenNFTMetadata memory greenNFTMetadata = greenNFTMetadatas[index];
        return greenNFTMetadata;
    }

    function getGreenNFTMetadataIndex(
        GreenNFT greenNFT
    ) public view returns (uint _greenNFTMetadataIndex) {
        address GREEN_NFT = address(greenNFT);

        // Identify member's index
        uint greenNFTMetadataIndex;
        for (uint i = 0; i < greenNFTAddresses.length; i++) {
            if (greenNFTAddresses[i] == GREEN_NFT) {
                greenNFTMetadataIndex = i;
            }
        }

        return greenNFTMetadataIndex;
    }

    function getGreenNFTMetadataByNFTAddress(
        GreenNFT greenNFT
    ) public view returns (GreenNFTMetadata memory _greenNFTMetadata) {
        address(greenNFT);

        // Identify member's index
        uint index = getGreenNFTMetadataIndex(greenNFT);

        GreenNFTMetadata memory greenNFTMetadata = greenNFTMetadatas[index];
        return greenNFTMetadata;
    }

    function getGreenNFTEmissonData(
        uint greenNFTMetadataId
    ) public view returns (GreenNFTEmissonData memory _greenNFTEmissonData) {
        // [Note]: The GreenNFTEmissonData and the GreenNFTMetadata has same greenNFTMetadataId
        uint index = greenNFTMetadataId.sub(1);
        GreenNFTEmissonData memory greenNFTEmissonData = greenNFTEmissonDatas[
            index
        ];
        return greenNFTEmissonData;
    }

    function getGreenNFTEmissonDataIndex(
        GreenNFT greenNFT
/// Gets the index of the GreenNFTEmissonData for the given GreenNFT contract.
///
/// This function iterates through the `greenNFTAddresses` array to find the index
/// of the GreenNFT contract address. This index is then returned as the
/// `_greenNFTEmissonDataIndex`.
///
/// @param greenNFT The GreenNFT contract to get the emission data index for.
/// @return _greenNFTEmissonDataIndex The index of the GreenNFTEmissonData for the given GreenNFT contract.
/**
     * Gets the index of the GreenNFTEmissonData associated with the given GreenNFT contract.
     *
     * @param greenNFT - The GreenNFT contract to get the GreenNFTEmissonData index for.
     * @return _greenNFTEmissonDataIndex - The index of the GreenNFTEmissonData associated with the given GreenNFT contract.
     */
            uint _greenNFTEmissonDataIndex
        )
    {
        address GREEN_NFT = address(greenNFT);

        // Identify member's index
        uint greenNFTEmissonDataIndex;
        for (uint i = 0; i < greenNFTAddresses.length; i++) {
            if (greenNFTAddresses[i] == GREEN_NFT) {
                greenNFTEmissonDataIndex = i;
            }
        }

        return greenNFTEmissonDataIndex;
    }

    function getGreenNFTEmissonDataByNFTAddress(
        GreenNFT greenNFT
    ) public view returns (GreenNFTEmissonData memory _greenNFTEmissonData) {
        address(greenNFT);

        // Identify member's index
        uint index = getGreenNFTEmissonDataIndex(greenNFT);

        GreenNFTEmissonData memory greenNFTEmissonData = greenNFTEmissonDatas[
            index
        ];
        return greenNFTEmissonData;
    }

    function getGreenNFTMetadatas()
        public
        view
        returns (GreenNFTMetadata[] memory _greenNFTMetadatas)
    {
        return greenNFTMetadatas;
    }

    function getGreenNFTEmissonDatas()
        public
        view
        returns (GreenNFTEmissonData[] memory _greenNFTEmissonDatas)
    {
        return greenNFTEmissonDatas;
    }

    function getAuditors() public view returns (address[] memory _auditors) {
        return auditors;
    }

    function getAuditor(uint index) public view returns (address _auditor) {
        return auditors[index];
    }
}
