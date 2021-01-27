import 'package:flutter/material.dart';

class PlantListSearchTextField extends StatelessWidget {
  final Function(String) onChangedSearchText;

  const PlantListSearchTextField({
    @required this.onChangedSearchText,
  }) : assert(onChangedSearchText != null);

  @override
  Widget build(BuildContext context) => TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Search',
        ),
        onChanged: onChangedSearchText,
      );
}
