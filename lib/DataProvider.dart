import 'dart:convert';

import 'package:flutter_playground/DataModel.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class DataProvider {
  static RxList<dynamic> dataList = [].obs;

  static Future<void> fetchData() async {
    final url = Uri.https('jsonplaceholder.typicode.com', '/todos');
    final response = await http.get(url);
    final List<DataModel> fetchedDataList = [];

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      for (Map i in jsonData) {
        fetchedDataList.add(DataModel.fromJson(i));
      }
      dataList.value = fetchedDataList;
    }
  }
}
