import {
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import hre from "hardhat";

describe("VotingContract", function () {
  async function deployVotingFixture() {
    const Voting = await hre.ethers.getContractFactory("VotingContract");
    const voting = await Voting.deploy([
      4,
      5,
      6
    ]);

    return { voting };
  }

  it("Should accurately tally votes", async function () {
    const { voting } = await loadFixture(deployVotingFixture);

    await voting.castVote(1);
    await voting.castVote(1);
    await voting.castVote(2);

    await voting.calculateWinner();

    const votesForCandidate1 = await voting.getVotes(1);
    const votesForCandidate2 = await voting.getVotes(2);
    const votesForCandidate3 = await voting.getVotes(3);

    expect(votesForCandidate1).to.equal(2);
    expect(votesForCandidate2).to.equal(1);
    expect(votesForCandidate3).to.equal(0);
  });

  it("Should correctly determine the winner", async function () {
    const { voting } = await loadFixture(deployVotingFixture);

    await voting.castVote(1);
    await voting.castVote(1);
    await voting.castVote(2);

    await voting.calculateWinner();

    const winner = await voting.getWinner();

    expect(winner).to.equal(1);
  });


});