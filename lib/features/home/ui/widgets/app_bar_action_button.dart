
import 'package:flutter/material.dart';

Widget appBarActionButton({required VoidCallback onPressed, required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal:  4.0),
    child: CircleAvatar(
      radius: 18,
      backgroundColor: Colors.grey.shade200,
      child: Center(child: IconButton(onPressed: onPressed, icon: Icon(icon,color: Colors.black54,size: 20, ) )),
    ),
  );
}
