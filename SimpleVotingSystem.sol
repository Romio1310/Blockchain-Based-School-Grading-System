// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleVotingSystem {
    address public owner;
    mapping(address => bool) public voters;
    mapping(string => uint256) public votes;
    bool public votingActive;

    event VoterRegistered(address voter);
    event VotingStarted();
    event Voted(address voter, string candidate);
    event VotingEnded();

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    modifier onlyWhenVotingActive() {
        require(votingActive, "Voting is not active");
        _;
    }

    modifier onlyWhenVotingEnded() {
        require(!votingActive, "Voting is still active");
        _;
    }

    function registerVoter(address _voter) public onlyOwner {
        require(!voters[_voter], "Voter is already registered");
        voters[_voter] = true;
        emit VoterRegistered(_voter);
    }

    function startVoting() public onlyOwner {
        votingActive = true;
        emit VotingStarted();
    }

    function vote(string memory _candidate) public onlyWhenVotingActive {
        require(voters[msg.sender], "You are not registered to vote");
        require(votes[_candidate] + 1 > votes[_candidate], "SafeMath: addition overflow");
        votes[_candidate]++;
        emit Voted(msg.sender, _candidate);
    }

    function endVoting() public onlyOwner onlyWhenVotingActive {
        votingActive = false;
        emit VotingEnded();
    }

    function getVotes(string memory _candidate) public view onlyWhenVotingEnded returns (uint256) {
        return votes[_candidate];
    }
}
