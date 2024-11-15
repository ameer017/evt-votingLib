// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

library VoteLib {
    struct Vote {
        address voter;
        uint256 candidateId;
    }

    struct Candidate {
        uint256 id;
        uint256 votes;
    }

    function tallyVotes(
        Vote[] memory votes
    ) internal pure returns (Candidate[] memory) {
        uint256 maxCandidateId = 0;
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].candidateId > maxCandidateId) {
                maxCandidateId = votes[i].candidateId;
            }
        }

        uint256[] memory candidateVotes = new uint256[](maxCandidateId + 1);

        for (uint256 i = 0; i < votes.length; i++) {
            candidateVotes[votes[i].candidateId]++;
        }

        Candidate[] memory candidates = new Candidate[](maxCandidateId + 1);

        for (
            uint256 candidateId = 0;
            candidateId <= maxCandidateId;
            candidateId++
        ) {
            candidates[candidateId].id = candidateId;
            candidates[candidateId].votes = candidateVotes[candidateId];
        }

        return candidates;
    }

    function calculateWinner(
        Candidate[] memory candidates
    ) internal pure returns (uint256) {
        uint256 winnerId = 0;
        uint256 maxVotes = 0;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].votes > maxVotes) {
                winnerId = candidates[i].id;
                maxVotes = candidates[i].votes;
            }
        }

        return winnerId;
    }
}
