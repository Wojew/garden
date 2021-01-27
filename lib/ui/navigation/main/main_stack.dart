import 'package:flutter/material.dart';

import '../../ui.dart';

class MainDestination {
  static const root = "/";
  static const plantForm = "/plantForm";
}

class MainStack extends StatelessWidget {
  final GlobalKey<NavigatorState> stackKey;
  const MainStack({
    @required this.stackKey,
  }) : assert(stackKey != null);

  Future<bool> _onWillPop() async {
    final isRoot = !(await stackKey.currentState.maybePop());
    return isRoot;
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: Navigator(
            key: stackKey,
            initialRoute: MainDestination.root,
            onGenerateRoute: (settings) => MaterialPageRoute(
              settings: settings,
              builder: (context) {
                final name = settings.name;
                final arguments = settings.arguments;
                switch (name) {
                  case MainDestination.root:
                    return PlantListScreenProvider();
                  case MainDestination.plantForm:
                    return PlantFormScreenProvider(
                      plantFormInputDto: arguments,
                    );
                  default:
                    return SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      );
}
