import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  static String id = 'SearchPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Search page'),
      ),
    );
  }
}
