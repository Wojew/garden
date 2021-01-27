import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/data.dart';
import 'domain/domain.dart';
import 'ui/ui.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await PlantDatabase().setup();
  runApp(
    GardenApp(),
  );
}

class GardenApp extends StatelessWidget {
  final mainStackKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.light(),
        home: MainStack(
          stackKey: mainStackKey,
        ),
      );
}
