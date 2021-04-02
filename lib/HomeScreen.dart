import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_playground/DataModel.dart';
import 'package:flutter_playground/DataProvider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoading = false;
  // List<DataModel> _dataList = [];

  // Future<void> getData() async {
  //   final url = Uri.https('jsonplaceholder.typicode.com', '/todos');
  //   final response = await http.get(url);
  //   final List<DataModel> fetchedDataList = [];

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     for (Map i in jsonData) {
  //       fetchedDataList.add(DataModel.fromJson(i));
  //     }
  //     setState(() {
  //       _dataList = fetchedDataList;
  //     });
  //   }
  // }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      _isLoading = !_isLoading;
    });
    DataProvider.fetchData().then((value) {
      setState(() {
        _isLoading = !_isLoading;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            _isLoading = !_isLoading;
          });
          return DataProvider.fetchData().then((value) {
            setState(() {
              _isLoading = !_isLoading;
            });
          });
        },
        child: Container(
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: DataProvider.dataList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(DataProvider.dataList[index].title),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
