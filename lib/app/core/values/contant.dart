
 import 'package:vku_vote/app/data/services/share_prefers.dart';

String rpc_url  = "http://127.0.0.1:7545";

  String key = 'adcdafcc826e2751562f96898ff6395609661d148c32359a778b5bb0b63c78f3';

  Future<String> getPrivateKey() async {
    String privateKey = await getKeyString('privateKey') ?? key;
    print("DCMN : $privateKey");
    return privateKey;
  }