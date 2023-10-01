import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  final List<String> category;
  final List<String> cuisine;
  final Function(List<String>) applyFilter;
  final List<String>? selectedItem;

  FilterScreen(
      {required this.category,
      required this.applyFilter,
      this.selectedItem,
      required this.cuisine});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> selectedcategory = [];

  @override
  void initState() {
    super.initState();
    selectedcategory = List.from(widget.selectedItem as Iterable);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              'Filter',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            )),
            Text(
              "Category",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Wrap(
              children: widget.category
                  .map((item) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: FilterChip(
                            padding: EdgeInsets.all(8.0),
                            selectedColor: Colors.blue,
                            showCheckmark: false,
                            label: Text(
                              item,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: selectedcategory.contains(item)
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            selected: selectedcategory.contains(item),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedcategory.add(item);
                                } else {
                                  selectedcategory.remove(item);
                                }
                              });
                            }),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              "Cuisine",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Wrap(
              children: widget.cuisine
                  .map((item) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: FilterChip(
                            padding: EdgeInsets.all(8.0),
                            selectedColor: Colors.blue,
                            showCheckmark: false,
                            label: Text(item,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: selectedcategory.contains(item)
                                        ? Colors.white
                                        : Colors.black)),
                            selected: selectedcategory.contains(item),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedcategory.add(item);
                                } else {
                                  selectedcategory.remove(item);
                                }
                              });
                            }),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: SizedBox(
                height: 50.0,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      widget.applyFilter(selectedcategory);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Apply",
                      style: TextStyle(fontSize: 18.0),
                    )),
              ),
            ),
            Center(
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedcategory.clear();
                        widget.applyFilter(selectedcategory);
                      });
                    },
                    child: Text(
                      "Clear Filter",
                      style: TextStyle(fontSize: 18.0),
                    )))
          ],
        ),
      ),
    );
  }
}
