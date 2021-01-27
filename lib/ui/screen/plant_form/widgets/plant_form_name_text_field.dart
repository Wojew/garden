import 'package:flutter/material.dart';

class PlantFormNameTextField extends StatelessWidget {
  final TextEditingController _controller;

  const PlantFormNameTextField({
    @required TextEditingController controller,
  })  : assert(controller != null),
        _controller = controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name',
        ),
      );
}
