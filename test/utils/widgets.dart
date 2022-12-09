import 'dart:async';
import 'dart:convert';
import 'package:clean_framework/clean_framework_providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:meta/meta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter/material.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restful_service/providers.dart';
import 'package:restful_service/routes.dart';

import '../stub/stub.dart';

Widget buildWidget(Widget widget) {
  return FeatureScope(
    register: () => FakeJsonFeatureProvider(),
    child: AppProvidersContainer(
      providersContext: providersContext,
      onBuild: (_, __) {},
      child: MaterialApp.router(
        routeInformationParser: router.informationParser,
        routerDelegate: router.delegate,
        routeInformationProvider: router.informationProvider,
      ),
    ),
  );
}

class FakeJsonFeatureProvider extends JsonFeatureProvider {
  final map = json.decode(stub(path: 'book', name: 'success'));
  FakeJsonFeatureProvider() {
    feed(
      {
        'data': map,
      },
    );
  }
}

// For image
@isTest
void uiTestWithMockedImage(
  String description, {
  required WidgetTesterCallback verify,
  required ProvidersContext context,
  UI Function()? builder,
  required AppRouter router,
  FutureOr<void> Function()? setup,
  FutureOr<void> Function(WidgetTester)? postFrame,
  bool wrapWithMaterialApp = true,
  Duration? pumpDuration,
  bool? skip,
  Timeout? timeout,
  bool semanticsEnabled = true,
  TestVariant<Object?> variant = const DefaultTestVariant(),
  dynamic tags,
  Size? screenSize,
  Iterable<LocalizationsDelegate<dynamic>>? localizationDelegates,
  Widget Function(Widget)? parentBuilder,
}) {
  assert(
    () {
      return localizationDelegates == null || wrapWithMaterialApp;
    }(),
    'Need to wrap with MaterialApp '
    'if overriding localization delegates is required',
  );

  final resolvedRouter = router;
  final resolvedContext = context;

  assert(
    () {
      return builder != null || resolvedRouter != null;
    }(),
    'Provide either "builder" or "router".',
  );
  assert(
    () {
      return resolvedRouter == null || wrapWithMaterialApp;
    }(),
    '"router" should not be passed when wrapWithMaterialApp is false',
  );
  assert(
    () {
      return resolvedContext != null;
    }(),
    'Either pass "context" or call "setupUITest()" before test block.',
  );

  testWidgets(
    description,
    (tester) async {
      await mockNetworkImagesFor(() async {
        final window = tester.binding.window;
        if (screenSize != null) {
          window.physicalSizeTestValue = screenSize * window.devicePixelRatio;
        }

        await setup?.call();

        Widget scopedChild(Widget child) {
          return uiTestWidgetBuilder(
            UncontrolledProviderScope(
              container: resolvedContext!(),
              child: child,
            ),
          );
        }

        Widget child;
        if (wrapWithMaterialApp) {
          if (builder == null) {
            resolvedRouter!.navigatorBuilder = (_, __, nav) => scopedChild(nav);
            child = MaterialApp.router(
              routeInformationParser: resolvedRouter.informationParser,
              routerDelegate: resolvedRouter.delegate,
              routeInformationProvider: resolvedRouter.informationProvider,
              localizationsDelegates: localizationDelegates,
            );
          } else {
            child = MaterialApp(
              home: scopedChild(builder()),
              localizationsDelegates: localizationDelegates,
            );
          }
        } else {
          child = scopedChild(builder!());
        }

        await tester.pumpWidget(
          parentBuilder == null ? child : parentBuilder(child),
          pumpDuration,
        );

        if (postFrame == null) {
          await tester.pumpAndSettle();
        } else {
          await postFrame(tester);
        }

        await verify(tester);

        if (screenSize != null) window.clearPhysicalSizeTestValue();
      });
    },
    skip: skip,
    timeout: timeout,
    semanticsEnabled: semanticsEnabled,
    variant: variant,
    tags: tags,
  );
}
