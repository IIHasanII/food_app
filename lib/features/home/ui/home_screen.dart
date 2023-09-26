import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/features/data/food_list.dart';
import 'package:food_app/features/app_components/filter_screen.dart';
import 'package:food_app/features/app_components/selected_item.dart';

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
  List<String> cuisines = ['Italian', 'American', 'Japanese','International'];
  List<String> selectedFilter = [];
 
 

  @override
  void initState() {
    super.initState();
    updateList = foodData;
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
              categorySearch.isEmpty || categorySearch.any((filter) => element["category"]
                  .toString()
                  .toLowerCase()
                  .contains(filter.toLowerCase()))||categorySearch.any((filter) => element["cuisine"]
                  .toString()
                  .toLowerCase()
                  .contains(filter.toLowerCase()))
              )
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
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchValue,
                      onChanged: (_searchValue) {
                        searchItem(_searchValue);
                      },
                      autofocus: false,
                      decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  SizedBox(
                      height: 60,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              backgroundColor:
                                  const Color.fromARGB(255, 87, 167, 129)),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((context) => FilterScreen(
                                      category: categories,
                                      cuisine: cuisines,
                                      applyFilter: filterList,
                                      selectedItem: selectedFilter,
                                      
                                    )));
                          },
                          child: const Icon(
                            Icons.filter_alt,
                            size: 30.0,
                          )))
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: StreamBuilder<QuerySnapshot>(
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
                              // final List<FoodModel> foodList = [];
    
                              // List<Map<String, dynamic>> data =
                              //     FoodList.foodItems;
                              // for (var food in data) {
                              //   foodList.add(FoodModel(
                              //       name: food['name'],
                              //       description: food['description'],
                              //       imageUrl: food['image_url']));
                              // }
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
                          }),
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

class CustomListTile extends StatelessWidget {
  final String? title;
  final String? description;
  final String? imageUrl;

  CustomListTile({this.title, this.imageUrl, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4.0,
            ),
          ]),
      child: Column(children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  image: imageUrl != null
                      ? NetworkImage(imageUrl!)
                      : const NetworkImage(
                          'https://media.cloudbooklet.com/uploads/2023/06/21111428/luma-ai-1-750x422.jpg'))),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          child: Text(
            title!,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Container(
          child: description != null ? Text(description!) : const Text('Empty'),
        )
      ]),
    );
  }
}
