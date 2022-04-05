class Candidate{
  int id;
  String name;
  String address;
  String description;
  String image;
  int numVotes;
  int? roomId;
  
  Candidate({
    required this.id,
    required this.name ,
    required this.address,
    required  this.description ,
    required  this.image ,
    required this.numVotes,
    this.roomId
  });

    Candidate copyWith({
      int? id,
      String? name,
      String? address,
      String? description,
      String? image,
      int? numVotes,
      int? roomId
    })  => Candidate(
      id: id ?? this.id, 
      name: name ?? this.name, 
      address: address ?? this.address, 
      description: description ?? this.description, 
      image: image ?? this.image, 
      numVotes: numVotes ?? this.numVotes,
      roomId: roomId ?? this.roomId
    );


    factory Candidate.fromJson(Map<String,dynamic> json) => Candidate(
      id: json['id'], 
      name: json['name'],
      address: json['address'], 
      description: json['description'], 
      image: json['image'], 
      numVotes: json['numVotes'], 
      roomId: json['roomId']
    );

    Map<String,dynamic> toJson()=>{
      'id' : id,
      'name' : name,
      'address' : address,
      'description' : description,
      'image' : image,
      'numVotes' : numVotes,
      'roomId' : roomId
    };
}