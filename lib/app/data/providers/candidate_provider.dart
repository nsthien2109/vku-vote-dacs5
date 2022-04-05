 import 'package:vku_vote/app/data/models/candidate_model.dart';
import 'package:vku_vote/app/data/providers/app_provider.dart';
import 'package:web3dart/web3dart.dart';

class CandidateProvider{
   final appProvider = AppProvider();
   Future<List<Candidate>> getCandidate() async {
     await appProvider.initial();
     var candidates = <Candidate>[];
     List candidateRoom = await appProvider.ethClient!.call(contract: appProvider.deployedContract!, function: appProvider.tempCount!, params: []);
     BigInt totalCandidate = candidateRoom[0];
     appProvider.candidateCount = totalCandidate.toInt();
     candidates.clear();
     for(int i = 0; i < appProvider.candidateCount; i++){
       var temp = await appProvider.ethClient!.call(contract: appProvider.deployedContract!, function: appProvider.tempCandidateRoom!, params: [BigInt.from(i)]);
       var candidate = Candidate(
         id: temp[0].toInt(),
         name: temp[1], 
         address: temp[2], 
         description: temp[3], 
         image: temp[4], 
         numVotes: temp[5].toInt()
        );
        candidates.add(candidate);
     }
     return candidates;
   }

    void getCandidateRoom(int roomID) async {
        await appProvider.initial();
        await appProvider.ethClient!.sendTransaction(appProvider.credentials!, Transaction.callContract(contract: appProvider.deployedContract!, function: appProvider.getRoomCandidates!, parameters: [BigInt.from(roomID)]));
    }
    
    void createCandidate(Candidate candidate,int roomId) async {
        await appProvider.initial();
        await appProvider.ethClient!.sendTransaction(appProvider.credentials!, Transaction.callContract(contract: appProvider.deployedContract!, function: appProvider.addCandidate!, parameters: [candidate.name,candidate.address,candidate.description,candidate.image,BigInt.from(roomId)]));
        await getCandidate();
    }

 }
