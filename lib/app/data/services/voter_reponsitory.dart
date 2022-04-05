import 'package:vku_vote/app/data/providers/voter_provider.dart';

class VoterReponsitory{
  VoterProvider voterProvider;
  VoterReponsitory({required this.voterProvider});
  getVoter() => voterProvider.getVoter();
  createVoter(String token, String name) => voterProvider.createVoter(token,name); 
  voteAction(int candidateIndex, int roomID) => voterProvider.voteAction(candidateIndex, roomID);
}