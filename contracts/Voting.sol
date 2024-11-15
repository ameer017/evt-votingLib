// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import "./VoteLib.sol";

contract VotingContract {
    struct Voter {
        address voter;
        uint256 candidateId;
    }

    Voter[] public voters;
    uint256[] public candidates;

    event VoteCast(address voter, uint256 candidateId);
    event WinnerCalculated(uint256 winnerId);

    constructor(uint256[] memory _candidates)  {
        candidates = _candidates;
    }

    function castVote(uint256 _candidateId) public {
        require(!hasVoted(msg.sender), "Voter has already voted");
        voters.push(Voter(msg.sender, _candidateId));
        emit VoteCast(msg.sender, _candidateId);
    }

    function hasVoted(address _voter) internal view returns (bool) {
        for (uint256 i = 0; i < voters.length; i++) {
            if (voters[i].voter == _voter) {
                return true;
            }
        }
        return false;
    }

    function calculateWinner() public {
        VoteLib.Vote[] memory votes = new VoteLib.Vote[](voters.length);
        for (uint256 i = 0; i < voters.length; i++) {
            votes[i].voter = voters[i].voter;
            votes[i].candidateId = voters[i].candidateId;
        }
        VoteLib.Candidate[] memory talliedCandidates = VoteLib.tallyVotes(votes);
        uint256 winnerId = VoteLib.calculateWinner(talliedCandidates);
        emit WinnerCalculated(winnerId);
    }

    function getWinner() public view returns (uint256) {
        return candidates[0];
    }

    function getVotes(uint256 _candidateId) public view returns (uint256) {
        return candidates[_candidateId];
    }
}