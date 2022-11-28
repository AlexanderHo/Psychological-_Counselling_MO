import 'package:astrology/Components/app_bar.dart';
import 'package:astrology/resourse/Search/Component/body.dart';
import 'package:flutter/material.dart';

import 'Component/Search_bar.dart';

class SearchScreen extends StatelessWidget {
  String searchKey;
  SearchScreen({required this.searchKey});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: TopBar.getAppBarHasBackIcon(size, context, 'Tư vấn viên', () {
        Navigator.pop(context);
      }),
      body: Container(
        child: Column(
          children: [
            SearchBar(searchText: searchKey),
            Expanded(child: Body(searchKey: searchKey))
          ],
        ),
      ),
    );
  }
}
