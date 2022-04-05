import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/candidate_model.dart';
import 'package:vku_vote/app/data/models/election_model.dart';
import 'package:vku_vote/app/data/models/voter_model.dart';
import 'package:vku_vote/app/data/providers/app_provider.dart';
import 'package:vku_vote/app/data/services/candidate_reponsitory.dart';
import 'package:vku_vote/app/data/services/election_reponsitory.dart';
import 'package:vku_vote/app/data/services/share_prefers.dart';
import 'package:vku_vote/app/data/services/voter_reponsitory.dart';

class HomeController extends GetxController{
  ElectionRepository electionRepository;
  CandidateReponsitory candidateReponsitory;
  VoterReponsitory voterReponsitory;
  HomeController({required this.electionRepository,required this.candidateReponsitory, required this.voterReponsitory});

  var elections = <Election>[].obs;
  var candidatesRoom = <Candidate>[].obs;
  var voters = <Voter>[].obs;
  var candidateCount = 0.obs;
  var isLogin = false.obs;
  var isLoading = false.obs;
  var isEnding = false.obs;
  var nameVoter = "".obs;
  var publicKeyVoter = "".obs;
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final editController1 = TextEditingController();
  final editController2 = TextEditingController();
  final editController3 = TextEditingController();
  final editController4 = TextEditingController();
  final appProvider = AppProvider();

  // thời gian - timer
  var day = 0.obs;
  var hour = 0.obs;
  var minutes = 0.obs;
  var second = 0.obs;
  var colorCountDown = Colors.black.obs;


  @override
  void onInit() async {
    await loginCheck();
    getDataVoter();
    elections.assignAll(await electionRepository.getElection());
    voters.value = await voterReponsitory.getVoter();
    super.onInit();
  }
  
  @override
  void onClose(){
    editController1.dispose();
    editController2.dispose();
    editController3.dispose();
    editController4.dispose();
    super.onClose();
  }

  void textFieldClear(){
      editController1.clear();
      editController2.clear();
      editController3.clear();
      editController4.clear();    
  }

    bool addElection(Election election){
    if (elections.contains(election)) {
      return false;
    } else {
      try {
        electionRepository.createElection(election);
        textFieldClear();
        elections.add(election);
      } catch (e) {
        rethrow;
      }
      return true;
    }
  }

  void getCandidateRoom(int roomID) async {
    isLoading.value = true;
    await candidateReponsitory.getCandidateRoom(roomID);
    candidatesRoom.clear();
    candidatesRoom.assignAll(await candidateReponsitory.getCandidate());
    isLoading.value = false;
  }

  bool addCandidate(Candidate candidate,int roomID){
    if(candidatesRoom.contains(candidate)){
      return false;
    }else{
      candidateReponsitory.createCandidate(candidate, roomID);
      textFieldClear();
      candidatesRoom.add(candidate);
      candidateCount.value ++;
    }
    return true;
  }

// Login
  Future<void> loginCheck() async {
    final logined = await getKeyBool('isLogin') ?? false;
    isLogin.value = logined;
  }

  Future<bool> login(Voter voter) async{
    print("Số lượng voter : ${voters.length}");
    appProvider.initial();
    bool isAccount = false;
    var public = await appProvider.getPublicKey(voter.token);
    await setKeyString('privateKey', voter.token);
    for (var i = 0; i < voters.length ; i++) {
      if (voters[i].token == public.toString().toLowerCase()) {
        await setKeyString('AdressVoter', voters[i].token);
        isAccount = true;
        await setKeyString('NameVoter', voters[i].name);
        await setKeyBool('isLogin', true);
        getDataVoter();
        loginCheck();
        textFieldClear();
        return true;
      }
    }
    createVoter(isAccount, voter,public.toString());
    textFieldClear();
    return isAccount;
  }

  Future<bool> createVoter(bool isAccount,Voter voter, String publicKey) async {
    if(isAccount == false){
      if (voter.name == "") {
        int numberRandom = 1000 + Random().nextInt(10000 - 1000);
        voter.name = "Unknow $numberRandom";
        await voterReponsitory.createVoter(voter.token, voter.name);
        setKeyString('NameVoter', voter.name);
        setKeyString('AdressVoter', publicKey);
        setKeyBool('isLogin', true);
        voters.value = await voterReponsitory.getVoter();
        getDataVoter();
        loginCheck();
        voters.add(voter);
        return isAccount;
      }else{
        await voterReponsitory.createVoter(voter.token, voter.name);
        setKeyString('NameVoter', voter.name);
        setKeyBool('isLogin', true);
        setKeyString('AdressVoter', publicKey);
        voters.value = await voterReponsitory.getVoter();
        getDataVoter();
        loginCheck();
        voters.add(voter);
        return isAccount;
      }
    }
    return isAccount;
  }

  void getDataVoter() async {
    nameVoter.value = await getKeyString('NameVoter') ?? "";
    publicKeyVoter.value = await getKeyString('AdressVoter') ?? "";
  }

  void logout() async {
    await removeKey('NameVoter');
    await removeKey('AdressVoter');
    await removeKey('privateKey');
    await removeKey('isLogin');
    textFieldClear();
    isLogin.value = false;
  }


  void voteAction(int candidateIndex, int roomID) async {
    isLoading.value = true;
    await voterReponsitory.voteAction(candidateIndex, roomID);
    getCandidateRoom(roomID);
    isLoading.value = false;
  }


  void renderTime(Election election){
    isEnding.value = false;
    var now = DateTime.now();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    var startTime = inputFormat.parse(election.startTime.toString());
    var endTime = inputFormat.parse(election.endTime.toString());
    if(now.isBefore(startTime)){
      isEnding.value = false;
      print("Chưa đến thời gian bầu cử");
      day.value = endTime.day - now.day;
      hour.value = endTime.hour - now.hour;
      minutes.value = endTime.minute - now.minute;
      second.value = endTime.second - now.second;
      colorCountDown.value = Colors.red;
    }
    if(now.isAfter(startTime) && now.isBefore(endTime)){
      isEnding.value = false;
      print("Trong thời gian bầu cử");
      day.value = endTime.day - now.day;
      hour.value = endTime.hour - now.hour;
      minutes.value = endTime.minute - now.minute;
      second.value = endTime.second - now.second;
      colorCountDown.value = Colors.green;
    }
    if(now.isAfter(endTime)){
      print("Thời gian bầu cử kết thúc");
      isEnding.value = true;
      colorCountDown.value = primaryColor;
    }
  }
}