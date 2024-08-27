# SchoolGradingSystem - Solidity Smart Contract

This Solidity program is a smart contract that demonstrates the basic syntax and functionality of error handling in Solidity. The purpose of this program is to serve as a starting point for those who are new to Solidity and want to understand how to implement error handling using `require()`, `revert()`, and `assert()` statements in a real-life scenario of a simple school grading system.

## Description

This program is a smart contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. The contract includes functions that showcase the usage of `require()`, `revert()`, and `assert()` statements for error handling within the context of a simple school grading system. This program serves as a straightforward introduction to Solidity error handling and can be used as a foundation for more complex projects in the future.

## Getting Started

### Executing the Program

To run this program, you can use Remix, an online Solidity IDE. Follow these steps to get started:

1. Go to the Remix website at [Remix Ethereum](https://remix.ethereum.org/).

2. Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a `.sol` extension (e.g., `SchoolGradingSystem.sol`). Copy and paste the following code into the file:

    ```solidity
    
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.7;

    contract SchoolGradingSystem {
        address public owner;
        bool public gradingActive;

    struct Student {
        string name;
        uint256 grade;
        bool exists;
    }

    mapping(address => Student) public students;

    event StudentAdded(address studentAddress, string name);
    event GradeAssigned(address studentAddress, uint256 grade);
    event GradeUpdated(address studentAddress, uint256 newGrade);
    event GradingStarted();
    event GradingEnded();

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action"); // Ownership validation
        _;
    }

    modifier onlyWhenGradingActive() {
        require(gradingActive, "Grading is not active");                   // Grading activity check
        _;
    }

    modifier onlyWhenGradingEnded() {
        require(!gradingActive, "Grading is still active");                // Grading ended check
        _;
    }

    modifier studentExists(address _student) {
        require(students[_student].exists, "Student does not exist");      // Student existence check
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addStudent(address _student, string memory _name) public onlyOwner {
        if (students[_student].exists) {
            revert("Student is already registered");                        // Custom error handling using revert()
        }
        students[_student] = Student(_name, 0, true);
        emit StudentAdded(_student, _name);
    }

    function startGrading() public onlyOwner {
        gradingActive = true;
        assert(gradingActive == true);                                     // Assert grading has started
        emit GradingStarted();
    }

    function assignGrade(address _student, uint256 _grade) 
        public 
        onlyOwner 
        onlyWhenGradingActive 
        studentExists(_student) 
    {
        require(_grade <= 100, "Grade must be between 0 and 100");         // Grade validation
        students[_student].grade = _grade;
        emit GradeAssigned(_student, _grade);
    }

    function updateGrade(address _student, uint256 _newGrade) 
        public 
        onlyOwner 
        onlyWhenGradingActive 
        studentExists(_student) 
    {
        require(_newGrade <= 100, "Grade must be between 0 and 100");       // Grade validation
        students[_student].grade = _newGrade;
        emit GradeUpdated(_student, _newGrade);
    }

    function endGrading() public onlyOwner onlyWhenGradingActive {
        gradingActive = false;
        assert(gradingActive == false); // Assert grading has ended
        emit GradingEnded();
    }

    function getStudentGrade(address _student) 
        public 
        view 
        onlyWhenGradingEnded 
        studentExists(_student) 
        returns (uint256) 
    {
        return students[_student].grade;
    }
    } 

    ```

3. To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.7" (or another compatible version), and then click on the "Compile SchoolGradingSystem.sol" button.

4. Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar.

5. Select the "SchoolGradingSystem" contract from the dropdown menu, and then click on the "Deploy" button.

6. Once the contract is deployed, you can interact with it by calling its functions:
   - To add a student, input the student's address and name in the `addStudent` function.
   - To start the grading process, call the `startGrading` function.
   - To assign a grade to a student, use the `assignGrade` function with the student's address and grade.
   - To update a student's grade, use the `updateGrade` function with the student's address and the new grade.
   - To end the grading process, call the `endGrading` function.
   - To get the grade of a student, use the `getStudentGrade` function with the student's address.

## Examples

- **Add Student:**
    - Input: `addStudent("0x1234...", "John Doe")`
    - Output: Event `StudentAdded` emitted with student address `0x1234...` and name `John Doe`.

- **Start Grading:**
    - Input: `startGrading()`
    - Output: Event `GradingStarted` emitted, indicating that grading is now active.

- **Assign Grade:**
    - Input: `assignGrade("0x1234...", 85)`
    - Output: Event `GradeAssigned` emitted with student address `0x1234...` and grade `85`.

- **Update Grade:**
    - Input: `updateGrade("0x1234...", 90)`
    - Output: Event `GradeUpdated` emitted with student address `0x1234...` and new grade `90`.

- **End Grading:**
    - Input: `endGrading()`
    - Output: Event `GradingEnded` emitted, indicating that grading is now closed.

- **Get Student Grade:**
    - Input: `getStudentGrade("0x1234...")`
    - Output: Returns the grade that the student with address `0x1234...` has received.

---

Feel free to explore and modify the code to better understand error handling in Solidity. This contract provides a simple yet powerful foundation for learning and developing more complex smart contracts with robust error handling mechanisms.
