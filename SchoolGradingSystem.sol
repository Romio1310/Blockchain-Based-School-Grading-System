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
        require(_newGrade <= 100, "Grade must be between 0 and 100");      // Grade validation
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
