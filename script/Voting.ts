// Write a script to deploy the Voting contract 
// Cast votes for the Voting contract and retrieve the winner.


const hre = require("hardhat");


async function main() {
    const Voting = await hre.ethers.getContractFactory("VotingContract");
    const voting = await Voting.deploy([
        1,
        2,
        3
    ]);

    console.log("VotingContract deployed to:", voting.target);

    const candidateId = 1;
    await voting.castVote(candidateId);

    const votes = await voting.getVotes(candidateId);
    console.log("Votes for candidate", candidateId, ":", votes);

    const retrieveWinner = await voting.getWinner();
    console.log("Winner:", retrieveWinner);

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});