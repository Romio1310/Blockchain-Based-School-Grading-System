# SimpleVotingSystem - Solidity Smart Contract

This Solidity program is a smart contract that demonstrates the basic syntax and functionality of error handling in Solidity. The purpose of this program is to serve as a starting point for those who are new to Solidity and want to understand how to implement error handling using `require()`, `revert()`, and `assert()` statements in a real-life scenario of a simple voting system.

## Description

This program is a smart contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract includes functions that showcase the usage of `require()`, `revert()`, and `assert()` statements for error handling within the context of a simple voting system. This program serves as a straightforward introduction to Solidity error handling and can be used as a foundation for more complex projects in the future.

## Getting Started

### Executing the Program

To run this program, you can use Remix, an online Solidity IDE. Follow these steps to get started:

1. Go to the Remix website at [Remix Ethereum](https://remix.ethereum.org/).

2. Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a `.sol` extension (e.g., `SimpleVotingSystem.sol`). Copy and paste the following code into the file:

    ```solidity
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
    ```

3. To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.7" (or another compatible version), and then click on the "Compile SimpleVotingSystem.sol" button.

4. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar.

5. Select the "SimpleVotingSystem" contract from the dropdown menu, and then click on the "Deploy" button.

6. Once the contract is deployed, you can interact with it by calling its functions:
   - To register a voter, input the voter's address in the `registerVoter` function.
   - To start the voting process, call the `startVoting` function.
   - To cast a vote, use the `vote` function with the candidate's name.
   - To end the voting process, call the `endVoting` function.
   - To check the vote count for a candidate, use the `getVotes` function with the candidate's name.

## Examples

- **Register Voter:**
    - Input: `registerVoter("0x1234...")`
    - Output: Event `VoterRegistered` emitted with voter address `0x1234...`.

- **Start Voting:**
    - Input: `startVoting()`
    - Output: Event `VotingStarted` emitted, indicating that voting is now active.

- **Cast Vote:**
    - Input: `vote("Alice")`
    - Output: Event `Voted` emitted with voter address and candidate `Alice`.

- **End Voting:**
    - Input: `endVoting()`
    - Output: Event `VotingEnded` emitted, indicating that voting is now closed.

- **Get Votes:**
    - Input: `getVotes("Alice")`
    - Output: Returns the number of votes `Alice` has received.

---

Feel free to explore and modify the code to better understand error handling in Solidity. This contract provides a simple yet powerful foundation for learning and developing more complex smart contracts with robust error handling mechanisms.
