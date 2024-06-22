// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

contract VoterValidation {
    struct Voter {
        bool isEligible;
        uint256 age;
        string voterId;
    }

    mapping(address => Voter) public voters;

    // Function to register a voter
    function registerVoter(uint256 _age, string memory _voterId) public {
        require(_age >= 18, "Must be 18 years or older to register.");
        require(validateVoterId(_voterId), "Invalid voter ID format.");

        voters[msg.sender] = Voter(true, _age, _voterId);
    }

    // Function to check if a voter is eligible
    function checkEligibility() public view returns (bool) {
        Voter memory voter = voters[msg.sender];
        return voter.isEligible;
    }

    // Internal function to validate voter ID format
    function validateVoterId(string memory _voterId) internal pure returns (bool) {
        bytes memory idBytes = bytes(_voterId);
        if (idBytes.length != 9) return false;
        if (idBytes[0] != bytes1("H") || idBytes[1] != bytes1("N") || idBytes[2] != bytes1("F")) return false;
        for (uint i = 3; i < 9; i++) {
            if (idBytes[i] < bytes1("0") || idBytes[i] > bytes1("9")) return false;
        }
        return true;
    }
}
