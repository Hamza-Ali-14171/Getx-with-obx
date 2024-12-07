import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  List serviceProvider = <Map<String, dynamic>>[].obs;

  getData() async {
    String url = "http://softcodix.pythonanywhere.com/api/serviceprovider/";
    var uri = Uri.parse(url);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var body = response.body;
      var data = jsonDecode(body);

      // Ensure data is a List and convert it to List<Map<String, dynamic>>
      if (data is List) {
        serviceProvider =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
      } else {
        print("Unexpected data format: $data");
      }

      update(); // Notify listeners about the update
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  updateData({required int id, required String name, required comments}) async {
    String url = "http://softcodix.pythonanywhere.com/api/serviceprovider/$id/";
    var uri = Uri.parse(url);
    var response = await http.put(uri,
        headers: {"Context-Type": "application/json"},
        body: jsonEncode({"name": name, "comments": comments}));
    getData();
    update();
  }

  deleteData(int id) async {
    String url = "http://softcodix.pythonanywhere.com/api/serviceprovider/$id/";
    var uri = Uri.parse(url);
    var response = await http.delete(uri);
    getData();
  }
}
