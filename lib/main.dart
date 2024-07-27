import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:growit/infrastructure/shared/services/auth_services.dart';
import 'package:growit/infrastructure/theme/theme_data.dart';

import 'firebase_options.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initialRoute = await Routes.initialRoute;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await intilizeServices();
  runApp(Main(initialRoute));
}

intilizeServices() async {
  await Get.putAsync(() async => AuthService());
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      theme: mainTheme(context),
      debugShowCheckedModeBanner: false,
      getPages: Nav.routes,
    );
  }
}
