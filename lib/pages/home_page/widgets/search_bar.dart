import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final VoidCallback onPressed;
  final bool isSwitched;
  final ValueChanged<bool> onSwitched;

  const CustomSearchBar({
    required this.labelText,
    required this.controller,
    required this.onPressed,
    required this.isSwitched,
    required this.onSwitched,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: controller,
          onSubmitted: (_) => onPressed(),
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSwitched ? Icons.wifi : Icons.wifi_off, // Display different icons
                  size: 24.0,
                  color: isSwitched ? Colors.green : Colors.green,
                ),
                Switch(
                  value: isSwitched,
                  onChanged: onSwitched,
                ),
              ],
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}
