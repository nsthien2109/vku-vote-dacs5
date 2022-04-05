import 'package:vku_vote/app/data/models/voter_model.dart';
import 'package:vku_vote/app/data/providers/app_provider.dart';
import 'package:web3dart/web3dart.dart';

class VoterProvider{
  final appProvider = AppProvider();

  Future<List<Voter>> getVoter()async {
    await appProvider.initial();
    var voters = <Voter>[];
    List votersData = await appProvider.ethClient!.call(contract: appProvider.deployedContract!, function: appProvider.voterCount!, params: []);
    BigInt totalVoters = votersData[0];
    appProvider.voterListCount = totalVoters.toInt();
    voters.clear();
    for (var i = 0; i < appProvider.voterListCount; i++) {
      var temp = await appProvider.ethClient!.call(contract: appProvider.deployedContract!, function: appProvider.votersArr!, params: [BigInt.from(i)]);
      var voter = Voter(
        token: temp[1].toString(), 
        name: temp[0], 
        authorised: temp[2], 
        whom: [], 
        electionRoom: []
      );
      voters.add(voter);
    }

    return voters;
  }

  void createVoter(String token, String name) async {
    await appProvider.initial();
    var publicKey = await appProvider.getPublicKey(token);
    await appProvider.ethClient!.sendTransaction(appProvider.credentials!, Transaction.callContract(contract: appProvider.deployedContract!, function: appProvider.addVoter!, parameters: [name,publicKey]));
    await getVoter();
  }


  void voteAction(int candidateIndex,int roomID) async {
    await appProvider.initial();
    await appProvider.ethClient!.sendTransaction(appProvider.credentials!, Transaction.callContract(contract: appProvider.deployedContract!, function: appProvider.vote!, parameters: [BigInt.from(candidateIndex),BigInt.from(roomID)]));
  }
}