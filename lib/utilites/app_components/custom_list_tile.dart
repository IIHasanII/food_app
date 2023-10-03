import 'package:flutter/material.dart';

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


