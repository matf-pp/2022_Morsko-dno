import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.maximize();
    await windowManager.setMinimumSize;
    await windowManager.setMinimizable(true);
    await windowManager.show();
    await windowManager.setSkipTaskbar(false);
  });
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
