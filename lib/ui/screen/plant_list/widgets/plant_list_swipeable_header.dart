import 'package:flutter/material.dart';
import '../../../ui.dart';

class PlantListSwipeableHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CustomHeader(
        builder: (context, mode) => Center(
          child: Padding(
            padding: EdgeInsets.all(Dimens.smallSpacing),
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
