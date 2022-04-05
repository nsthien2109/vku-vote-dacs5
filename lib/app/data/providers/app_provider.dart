import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:vku_vote/app/core/values/contant.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class AppProvider{
    int electionCount = 0;
    int candidateCount = 0;
    int tempCandidateRoomCount = 0;
    int voterListCount = 0;

    Web3Client? ethClient;
    String? abiCode;
    Credentials? credentials;
    Credentials? credentialVoter;
    EthereumAddress? ethAddress;
    DeployedContract? deployedContract;

    // Contract function of election
    ContractFunction? electingRoom; // electingRoom => mang chua election kieu array
    ContractFunction? electingCount; // electingCount => biren dem co bao nhieu electionRoon
    ContractFunction? electingsMap; //electings => mang chua election kieu mapping
    ContractFunction? createElectionRoom; //createElectionRoom => create electionRoom function
    ContractFunction? deleteElection; //deleteElecting => xoa phong
    ContractFunction? checkEndElection; // checkEndElection => check end elction 
    ContractFunction? tempCandidateRoom; // checkEndElection => check end elction 
    ContractFunction? tempCount; // checkEndElection => check end elction 


    // Contract function of candidate
    ContractFunction? candidatesCount; // candidatesCount => bien dem co bao nhieu candidates
    ContractFunction? candidatesMap;
    ContractFunction? addCandidate; //addCandidate => them candidate
    ContractFunction? deleteCandidate; //deleteCandidate => xoa ung cu vien
    ContractFunction? getRoomCandidates; //getRoomCandidates => kiem tra so luong candidate tròng phong
    ContractFunction? checkWinner; // checkWinner => kiem tra nguoi chien thang 

    // Contract function of voter
    ContractFunction? votersArr; //votersArr=> mang chua list cac voter dể truy xuất vào các phòng
    ContractFunction? voterCount; //votedCount => bien dem voter
    ContractFunction? votersMap;
    ContractFunction? totalVotes; //totalVotes => dem tat ca cac votes
    ContractFunction? addVoter; //addVoter => them voter . cai nay dang nhap vao la them r
    ContractFunction? vote;  // chuc nang bau cu khi click vao nut

    ContractFunction? owner; // owner => lưu ma hex cua owner
    ContractFunction? getBalance;

    // Contract event of Election smart contract
    ContractEvent? candidateAdd; //CandidateAdd => su kien them ung cu vien
    ContractEvent? candidateRemove; //CandidateRemove => su kien xoa ung cu vien
    ContractEvent? electionAdd; //ElectionAdd => sk them phong bau cu
    ContractEvent? electionRemove; //ElectionRemove => sk xoa phong bau cu
    ContractEvent? voterAdd; //VoterAdd => them voter :) dang nhap la them
    ContractEvent? voteEvent; //Vote => su kien khi nhan vote

  initial() async {
    ethClient = Web3Client(rpc_url, Client() , socketConnector: (){
      return IOWebSocketChannel.connect(rpc_url).cast<String>();
    });
    await getAbi();
    await getCreadentials();
    await getDeployContract();
  }

  Future<void> getAbi() async {
    String abiFile = await rootBundle.loadString('blockchain/build/contracts/Election.json');
    var jsonAbi = jsonDecode(abiFile);
    abiCode = jsonEncode(jsonAbi['abi']);
    ethAddress = EthereumAddress.fromHex(jsonAbi['networks']['5777']['address']);
  }

  Future<void> getCreadentials() async {
    String key = await getPrivateKey();
    // ignore: deprecated_member_use
    credentials = await ethClient!.credentialsFromPrivateKey(key);
  }

  Future<void> getCreadentialVoter(String keyPrivate) async {
    // ignore: deprecated_member_use
    credentialVoter = await ethClient!.credentialsFromPrivateKey(keyPrivate);
  }


  Future<EthereumAddress> getPublicKey(String keyPrivate) async {
    // ignore: deprecated_member_use
    credentialVoter = await ethClient!.credentialsFromPrivateKey(keyPrivate);
    var public = await credentialVoter!.extractAddress();
    print("public key : $public");
    return public;
  }

  Future<void> getDeployContract() async {
    await getAbi();
    deployedContract = DeployedContract(ContractAbi.fromJson(abiCode!, "Election"),ethAddress!);

    electingRoom = deployedContract!.function("electingRoom");
    electingCount = deployedContract!.function("electingCount");
    electingsMap = deployedContract!.function("electings");
    createElectionRoom = deployedContract!.function("createElectionRoom");
    deleteElection = deployedContract!.function("deleteElecting");
    checkEndElection = deployedContract!.function("checkEndElection");
    tempCandidateRoom = deployedContract!.function("tempRoom");
    tempCount = deployedContract!.function("tempCount");


    candidatesCount = deployedContract!.function("candidatesCount");
    candidatesMap = deployedContract!.function("candidates");
    addCandidate = deployedContract!.function("addCandidate");
    deleteCandidate = deployedContract!.function("deleteCandidate");
    getRoomCandidates = deployedContract!.function("getRoomCandidates");
    checkWinner = deployedContract!.function("checkWinner");

    votersArr = deployedContract!.function("votersArr");
    voterCount = deployedContract!.function("votedCount");
    votersMap = deployedContract!.function("voters");
    totalVotes = deployedContract!.function("totalVotes");
    addVoter = deployedContract!.function("addVoter");
    vote = deployedContract!.function("vote");
    
    owner = deployedContract!.function("owner");

    candidateAdd =  deployedContract!.event("CandidateAdd");
    candidateRemove = deployedContract!.event("CandidateRemove");
    electionAdd = deployedContract!.event("ElectionAdd");
    electionRemove = deployedContract!.event("ElectionRemove");
    voterAdd = deployedContract!.event("VoterAdd");
    voteEvent = deployedContract!.event("Vote");
  }
}