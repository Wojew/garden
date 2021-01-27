import 'package:flutter/material.dart';

import '../../ui.dart';

class VerticalSpacing extends StatelessWidget {
  final double spacing;

  const VerticalSpacing({
    this.spacing = Dimens.smallSpacing,
  }) : assert(spacing != null && spacing >= 0);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: spacing,
      );
}
