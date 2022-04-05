import 'package:vku_vote/app/data/models/election_model.dart';
import 'package:vku_vote/app/data/providers/election_provider.dart';

class ElectionRepository{
  ElectionProvider electionProvider;
  ElectionRepository({required this.electionProvider});
  getElection() => electionProvider.getElection();
  void createElection(Election election) => electionProvider.createElection(election);
}