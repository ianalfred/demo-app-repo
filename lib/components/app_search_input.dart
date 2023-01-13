import 'package:driver/components/app_font.dart';
import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({Key? key}) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 17.0,
        fontFamily: AppFont.font,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        labelText: "Search...",
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 104, 104, 104),
          fontSize: 17.0,
          fontFamily: AppFont.font,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color(0xffb9b9bb),
          ),
        ),
        prefixIcon: const Icon(Icons.search),
      ),
    );
  }
}
