import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:restful_service/routes.dart';

import 'providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loadProviders();
  runApp(const RestfulServiceApp());
}

class RestfulServiceApp extends StatelessWidget {
  const RestfulServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvidersContainer(
      providersContext: providersContext,
      child: MaterialApp.router(
        routeInformationParser: router.informationParser,
        routerDelegate: router.delegate,
        routeInformationProvider: router.informationProvider,
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
      ),
    );
  }
}
