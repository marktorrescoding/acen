import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final VoidCallback onPressed;

  const CustomSearchBar({
    required this.labelText,
    required this.controller,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onSubmitted: (_) => onPressed(),
        style: TextStyle(color: Colors.black), // Set the text color to black
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black), // Set the label color to black
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: onPressed,
          ),
          filled: true, // Set the background color to white
          fillColor: Colors.white, // Set the background color to white
        ),
      ),
    );
  }
}
