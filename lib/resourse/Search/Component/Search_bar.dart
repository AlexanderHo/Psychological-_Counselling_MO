import 'package:astrology/resourse/Search/Search.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  String searchText = "Search";
  SearchBar({required this.searchText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextFormField(
        onFieldSubmitted: (value) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SearchScreen(searchKey: value);
            },
          ));
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(90)),
                borderSide: BorderSide(
                    color: Color.fromRGBO(251, 189, 195, 1), width: 3)),
            hintText: searchText,
            hintStyle: TextStyle(
              color: Colors.red[200],
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.red[200],
            )),
      ),
    );
  }
}
