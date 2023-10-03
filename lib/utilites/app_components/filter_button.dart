import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final Function() onPressed;

  FilterButton({ required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                backgroundColor:
                    const Color.fromARGB(255, 87, 167, 129)),
            onPressed: onPressed,
            child: const Icon(
              Icons.filter_alt,
              size: 30.0,
            ))
        );
  }
}