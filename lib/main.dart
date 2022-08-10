import 'package:flutter/material.dart';
import 'package:houzeo_example/common/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  runApp(MyApp(
    scaffoldMessengerKey,
    navigatorKey,
  ));
}

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp(this.scaffoldMessengerKey, this.navigatorKey, {Key? key})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Houzeo Example",
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
      initialRoute: getInitialRoute(),
      routes: const {},
      onGenerateRoute: routeGenerator,
    );
  }
}
