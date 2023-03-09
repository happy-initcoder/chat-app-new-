import 'dart:convert';
import 'package:http/http.dart' as http;
import 'BaseUrl.dart';
import 'firendCollection.dart';

class GetDetailsAPI {
  static List<GetFriendDetail>? listResponse = [];
  static List<GetFriendDetail>? singleUserdetail = [];
  static int index = 0;

  static getIndexVal(int a) {
    index = a;
    // singleUserdetail?.add(GetDetailsAPI.listResponse![b]);
    // print(singleUserdetail);
  }

  static getConversation() async {
    http.Response response = await http.get(
      Uri.parse('${BaseUrl.baseUrl}/api/users/'),
    );

    List<GetFriendDetail> flist = [];

    if (response.statusCode == 200) {
      var urjson = json.decode(response.body);
      var jsonData = urjson['data'];

      for (var jData in jsonData) {
        flist.add(GetFriendDetail.fromJson(jData));
      }
    }
    return flist;
  }
}
