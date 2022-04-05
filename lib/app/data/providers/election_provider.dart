import 'package:vku_vote/app/data/models/election_model.dart';
import 'package:vku_vote/app/data/providers/app_provider.dart';
import 'package:web3dart/web3dart.dart';

class ElectionProvider{
  final appProvider = AppProvider();
  Future<List<Election>> getElection() async{
    await appProvider.initial();
    var elections = <Election>[];
    List electionRoom = await appProvider.ethClient!.call(contract: appProvider.deployedContract!, function: appProvider.electingCount!, params: []);
    BigInt totalRoom = electionRoom[0];
    appProvider.electionCount = totalRoom.toInt();
    elections.clear();
    for(int i = 0 ; i < appProvider.electionCount ; i ++ ){
      var temp = await appProvider.ethClient!.call(contract: appProvider.deployedContract!, function: appProvider.electingRoom!, params: [BigInt.from(i)]);
      var election = Election(
        id: temp[0].toInt(),
        name: temp[1], 
        description: temp[2], 
        keyRoom: temp[3], 
        authRoom: temp[5].toString(), 
        startTime: DateTime.fromMicrosecondsSinceEpoch(temp[4].toInt()), 
        endTime: DateTime.fromMicrosecondsSinceEpoch(temp[6].toInt())
      );
      elections.add(election);
    }
    return elections;
  }

  void createElection(Election elections) async {
    await appProvider.ethClient!.sendTransaction(appProvider.credentials!, Transaction.callContract(contract: appProvider.deployedContract!, function: appProvider.createElectionRoom!, parameters: [elections.keyRoom,elections.name,elections.description,EthereumAddress.fromHex(elections.authRoom),BigInt.from(elections.startTime.microsecondsSinceEpoch),BigInt.from(elections.endTime.microsecondsSinceEpoch)]));
    await getElection();
  }
}