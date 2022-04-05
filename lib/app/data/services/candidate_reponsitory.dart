import 'package:vku_vote/app/data/models/candidate_model.dart';
import 'package:vku_vote/app/data/providers/candidate_provider.dart';

class CandidateReponsitory{
  CandidateProvider candidateProvider;
  CandidateReponsitory({required this.candidateProvider});
  getCandidate()=> candidateProvider.getCandidate();
  getCandidateRoom(int roomId)=> candidateProvider.getCandidateRoom(roomId);
  createCandidate(Candidate candidate,int roomID) => candidateProvider.createCandidate(candidate, roomID);
}