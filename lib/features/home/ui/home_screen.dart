import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/utilites/app_components/constants.dart';
import 'package:food_app/utilites/app_components/custom_List_Tile.dart';
import 'package:food_app/utilites/app_components/filter_button.dart';
import 'package:food_app/data/food_list.dart';
import 'package:food_app/features/filter_screen_page/ui/filter_screen.dart';
import 'package:food_app/features/selected_item_page/ui/selected_item.dart';

final FirebaseFirestore _firebasestore = FirebaseFirestore.instance;

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchValue = TextEditingController();
  List<Map<String, dynamic>> updateList = [];
  List<Map<String, dynamic>> foodData = FoodList.foodItems;
  List<String> categories = ['Breakfast', 'Lunch', 'Dinner'];
  List<String> cuisines = ['Italian', 'American', 'Japanese', 'International'];
  List<String> selectedFilter = [];

  @override
  void initState() {
    super.initState();
    updateList = foodData;
  }

  StreamBuilder<QuerySnapshot<Object?>> buildFoodList() {
    return StreamBuilder<QuerySnapshot>(
                        stream: _firebasestore.collection("Food").snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("Error: ${snapshot.hasError}"),
                            );
                          } else {
                            
                            return ListView.builder(
                              itemCount: updateList.length,
                              itemBuilder: (context, index) {
                                final foodItem = updateList[index];

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  SelectedItem(
                                                    selectedItem:
                                                        updateList[index],
                                                  ))));
                                    });
                                  },
                                  child: CustomListTile(
                                    title: foodItem['name'],
                                    description: foodItem['description'],
                                    imageUrl: foodItem['image_url'],
                                  ),
                                );
                              },
                            );
                          }
                        });
  }

  Future<dynamic> bottomSheet(BuildContext context) async{
    return await showModalBottomSheet(
                              context: context,
                              builder: ((context) => FilterScreen(
                                    category: categories,
                                    cuisine: cuisines,
                                    applyFilter: filterList,
                                    selectedItem: selectedFilter,
                                  )));
  }

  TextField textField() {
    return TextField(
                    controller: _searchValue,
                    onChanged: (_searchValue) {
                      searchItem(_searchValue);
                    },
                    autofocus: false,
                    decoration: kSearchTextField(),
                  );
  }

  

  void searchItem(String search) {
    setState(() {
      updateList = foodData
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
    });
  }

  void filterList(List<String> categorySearch) {
    setState(() {
      selectedFilter = List.from(categorySearch);
      updateList = foodData
          .where((element) =>
              categorySearch.isEmpty ||
              categorySearch.any((filter) => element["category"]
                  .toString()
                  .toLowerCase()
                  .contains(filter.toLowerCase())) ||
              categorySearch.any((filter) => element["cuisine"]
                  .toString()
                  .toLowerCase()
                  .contains(filter.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Center(
                  child: Text(
                "Search",
                style: kMainHeadingStyle,
              )),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: textField(),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  FilterButton(onPressed:(){bottomSheet(context);},)
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: buildFoodList(),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }  
}