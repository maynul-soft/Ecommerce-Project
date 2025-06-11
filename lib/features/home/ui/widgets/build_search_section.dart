import 'package:flutter/material.dart';
class BuildSearchSection extends StatelessWidget {
  const BuildSearchSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (String? text){},
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        hintText: 'Search',
        hintStyle: TextStyle(fontSize: 20,color: Colors.black54,fontWeight: FontWeight.w300),
        prefixIcon: Icon(Icons.search,color: Colors.black54,),
        fillColor: Colors.grey.shade300,
        filled: true,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}