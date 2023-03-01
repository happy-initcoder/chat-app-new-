import 'dart:convert';

List<GetFriendDetail> getFriendDetailFromJson(String str) =>
    List<GetFriendDetail>.from(
        json.decode(str).map((x) => GetFriendDetail.fromJson(x)));

String getFriendDetailToJson(List<GetFriendDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFriendDetail {
  GetFriendDetail({
    required this.id,
    required this.username,
    required this.email,
  });

  String id;
  String username;
  String email;

  factory GetFriendDetail.fromJson(Map<String, dynamic> json) =>
      GetFriendDetail(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
      };
}
