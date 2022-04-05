import 'package:vku_vote/app/data/models/candidate_model.dart';

class Election{
    int id;
    String name;
    String description;
    String keyRoom;
    String authRoom;
    DateTime startTime;
    DateTime endTime;
    List<Candidate>? memberRoom;

    Election({
      required this.id,
      required this.name,
      required this.description,
      required this.keyRoom,
      required this.authRoom,
      required this.startTime,
      required this.endTime,
      this.memberRoom
    });

    Election copyWith({
      int? id,
      String? name,
      String? description,
      String? keyRoom,
      String? authRoom,
      DateTime? startTime,
      DateTime? endTime,
      List<Candidate>? memberRoom
    })  => Election(
      id: id ?? this.id, 
      name: name ?? this.name, 
      description: description ?? this.description, 
      keyRoom: keyRoom ?? this.keyRoom, 
      authRoom: authRoom ?? this.authRoom,
      startTime: startTime ?? this.startTime, 
      endTime: endTime ?? this.endTime,
      memberRoom: memberRoom ?? this.memberRoom
    );

    factory Election.fromJson(Map<String,dynamic> json) => Election(
      id: json['id'], 
      name: json['name'], 
      description: json['description'], 
      keyRoom: json['keyRoom'], 
      authRoom: json['authRoom'],
      startTime: json['startTime'], 
      endTime: json['endTime'],
      memberRoom: json['memberRoom']
    );

    Map<String,dynamic> toJson()=>{
      'id' : id,
      'name' : name,
      'description' : description,
      'keyRoom' : keyRoom,
      'authRoom' : authRoom,
      'startTime' : startTime,
      'endTime' : endTime,
      'memberRoom' : memberRoom
    };
}