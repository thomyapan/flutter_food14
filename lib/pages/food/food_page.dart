import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food/models/api_result.dart';
import 'package:flutter_food/models/food_item.dart';
import 'package:flutter_food/pages/food/food_list_page.dart';
import 'package:http/http.dart' as http;

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  var _selectedBottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Your Order',
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchFoods,
        child: Icon(Icons.add),
      ),
      body: _selectedBottomNavIndex == 0
          ? FoodListPage()
          : Container(
              child: Center(
                child: Text('YOUR ORDER',
                    style: Theme.of(context).textTheme.headline1),
              ),
            ),
    );
  }

  _fetchFoods() async {
    try {
      var list = (await _fetch('foods')) as List<dynamic>;
      var foodList = list.map((item) => FoodItem.fromJson(item)).toList();
      print('Number of foods: ${foodList.length}');
    } catch (e) {
      var msg = 'ERROR: $e';
      print(msg);
    }
  }

  Future<dynamic> _fetch(String endPoint) async {
    var url = Uri.parse('https://cpsu-test-api.herokuapp.com/$endPoint');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);

      var result = ApiResult.fromJson(jsonBody);

      print('STATUS: $result.status');

      if (result.status == 'ok') {
        return result.data;
      } else {
        throw Exception(result.message);
      }

      /*print(jsonBody['status']);
      print(jsonBody['data']);
      if (jsonBody['status'] == 'ok') {
        return jsonBody['data'];
      } else {
        throw Exception(jsonBody['message']);
      }*/
    } else {
      throw Exception('Server connection failed!');
    }
  }
}
