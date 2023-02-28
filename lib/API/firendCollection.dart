import 'dart:convert';

class getFriendDetail {
  String? sId;
  String? username;
  String? email;

  getFriendDetail({
    this.sId,
    this.username,
    this.email,
  });

  getFriendDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;

    return data;
  }

  toList() {}
}
