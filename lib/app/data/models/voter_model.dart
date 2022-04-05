class Voter{
  String token;
  String name;
  bool authorised;
  List<int>? whom; // danh sach nhung nguoi ma voiter nay bau chon
  List<int>? electionRoom; // danh sach nhung phong bau cu ma thang nay tham gia
  
  Voter({required this.token,required this.name,required this.authorised ,this.whom, this.electionRoom});
}