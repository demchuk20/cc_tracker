import 'package:flutter/material.dart';
import 'package:test_project/CCData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CCListState();
  }
}

class CCListState extends State {
  List<CCData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CC tracker'),
      ),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }

  _loadCC() async {
    final response =
        await http.get('https://api.coincap.io/v2/assets?limit=20');
    if (response.statusCode == 200) {
      var data = ((jsonDecode(response.body) as Map)['data']);
      var ccDataList = List<CCData>();
      data.forEach((value) {
        var temp = CCData(
            name: value['name'],
            symbol: value['symbol'],
            rank: int.parse(value['rank']),
            price: double.parse(value['priceUsd']));
        ccDataList.add(temp);
        setState(() {
          this.data = ccDataList;
        });
      });
    }
  }

  @override
  initState() {
    super.initState();
    _loadCC();
  }

  List<Widget> _buildList() {
    return data
        .map((CCData e) => ListTile(
              title: Text(e.symbol),
              subtitle: Text(e.name),
              leading: CircleAvatar(
                child: Text(e.rank.toString()),
              ),
              trailing: Text('\$${e.price.toStringAsFixed(3)}'),
            ))
        .toList();
  }
}
