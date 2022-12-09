import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restful_service/features/book/presentation/book_ui.dart';
import 'package:restful_service/providers.dart';
import 'package:restful_service/routes.dart';

import '../../../stub/stub.dart';
import '../../../utils/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final successResponse = json.decode(stub(path: "book", name: "success"));
  final gateway = bookGatewayProvider.getGateway(providersContext);
  gateway.transport = (request) async {
    return Right(
      RestSuccessResponse(
        data: successResponse,
      ),
    );
  };

  uiTestWithMockedImage(
    'should show list of books',
    builder: () => BookUI(),
    context: providersContext,
    router: router,
    verify: mockNetworkImagesFor(
      () => (tester) async {
        final bookItem = find.byType(BookItem);
        expect(bookItem, findsNWidgets(1));
        await tester.pumpAndSettle(const Duration(seconds: 2));
      },
    ),
  );

  uiTestWithMockedImage(
    'tapping on country tile should navigate to detail page',
    context: providersContext,
    router: router,
    parentBuilder: (child) => FeatureScope(
      register: () => FakeJsonFeatureProvider(),
      child: child,
    ),
    verify: (tester) async {
      router.to(Routes.book);
      await tester.pumpAndSettle();

      final bookItemFinder = find.byType(BookItem);

      expect(bookItemFinder, findsNWidgets(1));

      await tester.tap(bookItemFinder);
      await tester.pumpAndSettle();

      expect(router.location, '/detail');
    },
  );
}
