import 'package:flutter/material.dart';
//import 'package:food_app/features/data/food_list.dart';

class SelectedItem extends StatelessWidget {
  static const String id = 'SelectedItem';
  final selectedItem;
  SelectedItem({required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedItem['name']),
      ),
      body: SafeArea(
          child: ListView(
            children: [Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
            children: [
              Container(
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    image: DecorationImage(
                        image: NetworkImage(selectedItem['image_url']))),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(selectedItem['name'], style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 15.0,
              ),
              Text(selectedItem['description'], style: TextStyle(fontSize: 20.0),)
            ],
                  ),
                ),
          ])),
    );
  }
}
