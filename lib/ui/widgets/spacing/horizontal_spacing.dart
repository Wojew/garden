import 'package:flutter/material.dart';

import '../../ui.dart';

class HorizontalSpacing extends StatelessWidget {
  final double spacing;

  const HorizontalSpacing({
    this.spacing = Dimens.smallSpacing,
  }) : assert(spacing != null && spacing >= 0);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: spacing,
      );
}
