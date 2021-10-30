pragma solidity >=0.5.16;

contract Election {
    // Store candidate
    // Read candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    uint256 startTime = block.timestamp;
    event votedEvent (
        uint indexed _candidateId
    );

    function goingOn()  private view returns (bool) {
        return startTime - block.timestamp / 60 < 1;
    }

    mapping(uint => Candidate) public candidates;

    // Constructor
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    mapping(address => bool) public voters;



    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        require(goingOn());

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }

    uint public candidatesCount;
}
