import 'package:get/get.dart';
import 'package:vku_vote/app/data/providers/candidate_provider.dart';
import 'package:vku_vote/app/data/providers/election_provider.dart';
import 'package:vku_vote/app/data/providers/voter_provider.dart';
import 'package:vku_vote/app/data/services/candidate_reponsitory.dart';
import 'package:vku_vote/app/data/services/election_reponsitory.dart';
import 'package:vku_vote/app/data/services/voter_reponsitory.dart';
import 'package:vku_vote/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=> HomeController(
      electionRepository: ElectionRepository(
        electionProvider: ElectionProvider()
      ),
      candidateReponsitory: CandidateReponsitory(
        candidateProvider: CandidateProvider()
      ),
      voterReponsitory: VoterReponsitory(
        voterProvider: VoterProvider()
      )
    ));
  }
}