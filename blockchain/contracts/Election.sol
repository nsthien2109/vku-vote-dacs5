// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract Election{


    struct Electing{
        uint id;
        string name;
        string description;
        string keyRoom;
        uint256 startTime;
        address authRoom;
        uint256 endTime;
        Candidate[] memberRoom;
    }

    Electing[] public electingRoom;
    Candidate[] public tempRoom;
    uint public tempCount = 0;
    uint public electingCount = 0;
    mapping(uint => Electing) public electings;

    struct Candidate{
        uint256 id;
        string Cname;
        string Caddress;
        string description;
        string Cimage;
        uint numVotes;
    }

    uint public candidatesCount = 0;
    mapping (uint256 => Candidate) public candidates;

    struct Voter{
        string Vname;
        address token;
        bool authorised;
        uint[] whom;
        uint[] authorElection;
    }

    Voter[] public votersArr;
    uint public votedCount = 0;
    mapping(address => Voter) public voters;

    //
    address public owner;

    //
    uint public totalVotes;

    event CandidateAdd(uint id);
    event CandidateRemove(uint id);
    event ElectionAdd(uint id);
    event ElectionRemove(uint id);
    event VoterAdd(uint id);
    event Vote(uint id);


    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    constructor(){
        owner = msg.sender;
    }


    function getBalance() public view returns (uint256) {
        return owner.balance;
    }

    function createElectionRoom(
        string memory _keyRoom,
        string memory _title,
        string memory _description,
        address _authRoom,
        uint256 _startTime,
        uint256 _endTime
        ) public {
            uint _id = electingCount;
            Electing storage electing = electings[_id];
            electing.id = _id;
            electing.name = _title;
            electing.description = _description;
            electing.keyRoom = _keyRoom;
            electing.authRoom = _authRoom;
            electing.startTime = _startTime;
            electing.endTime = _endTime;
           // electing.memberRoom = ;

            electingRoom.push(electings[_id]);
            emit ElectionAdd(electingCount);
            electingCount++;
    }


    function addCandidate(
        string memory _candidateName,
        string memory _candidateAddress,
        string memory _description,
        string memory _candidateImage,
        uint selectedRoom
        ) public onlyOwner{
            uint _id = candidatesCount;
            Candidate storage candidate = candidates[_id];
            candidate.id = _id;
            candidate.Cname = _candidateName;
            candidate.Caddress = _candidateAddress;
            candidate.description = _description;
            candidate.Cimage = _candidateImage;
            candidate.numVotes = 0;

            electingRoom[selectedRoom].memberRoom.push(candidates[_id]);
            emit CandidateAdd(candidatesCount);
            candidatesCount++;
    }

    function deleteElecting(uint electingIndex) public {
        delete electings[electingIndex];
        delete electingRoom[electingIndex];
        emit ElectionRemove(electingIndex);
        electingCount --;
    }

    function deleteCandidate(uint candidateIndex,uint selectedRoom) public {
        delete candidates[candidateIndex];
        delete electingRoom[selectedRoom].memberRoom[candidateIndex];
        emit CandidateRemove(candidateIndex);
        candidatesCount --;
    }


    
    function getRoomCandidates(uint selectedRoom) public {
        tempCount = 0;
        delete tempRoom;
        for(uint i = 0 ;  i < electingRoom[selectedRoom].memberRoom.length ; i++){
            tempRoom.push(
                Candidate(
                    electingRoom[selectedRoom].memberRoom[i].id,
                    electingRoom[selectedRoom].memberRoom[i].Cname,
                    electingRoom[selectedRoom].memberRoom[i].Caddress,
                    electingRoom[selectedRoom].memberRoom[i].description,
                    electingRoom[selectedRoom].memberRoom[i].Cimage,
                    electingRoom[selectedRoom].memberRoom[i].numVotes
                )
            );
            tempCount++;
        }
    }

    function addVoter(
        string memory _nameVoter,
        address _voterAdress
        ) public {
            uint x = 0;
            for (uint256 i = 0; i < votersArr.length; i++) {
                if (votersArr[i].token != _voterAdress) {
                    x++;
                } else {
                    x--;
                }
            }
            if(x == votersArr.length){
                voters[_voterAdress].token = _voterAdress;
                voters[_voterAdress].authorised = true; 
                Voter storage voter = voters[_voterAdress];
                voter.Vname = _nameVoter;

                votersArr.push(voters[_voterAdress]);
                emit VoterAdd(votedCount);
                votedCount++;
            }
    }

    function vote(uint CandidateIndex,uint roomID) public {
        require(voters[msg.sender].authorised);
        uint whomLen = voters[msg.sender].whom.length;
        uint authorElectionLen = voters[msg.sender].authorElection.length;
        bool passWhom = true;
        bool passRoom = true;

        for(uint i = 0; i < whomLen ; i ++){
            if(voters[msg.sender].whom[i] == CandidateIndex){
                passWhom = false;
            }else{
                passWhom = true;
            }
        }
        for(uint i = 0;  i < authorElectionLen ; i++){
            if(voters[msg.sender].authorElection[i] == roomID){
                passRoom = false;
            }else{
                passRoom = true;
            }
        }

        if(passWhom && passRoom){
            voters[msg.sender].whom.push(CandidateIndex);
            voters[msg.sender].authorElection.push(roomID);
            candidates[CandidateIndex].numVotes++;
            electingRoom[roomID].memberRoom[CandidateIndex].numVotes++;
            emit Vote(totalVotes);
            totalVotes++;
        }
    }

    function checkEndElection(uint selectedRoom) public view returns (bool) {
        if(block.timestamp == electingRoom[selectedRoom].endTime){
            return true;
        }else{
            return false;
        }
    }

    function checkWinner(uint selectedRoom) public view returns (Candidate memory){
        require(checkEndElection(selectedRoom) == true ,"Chua het gio");
        uint len = electingRoom[selectedRoom].memberRoom.length;
        Candidate storage temp = electingRoom[selectedRoom].memberRoom[0];
        for(uint i = 0; i < len; i++){
            if(electingRoom[selectedRoom].memberRoom[i].numVotes > temp.numVotes){
                temp = electingRoom[selectedRoom].memberRoom[i];
            }
        }
        return temp;
    }
}