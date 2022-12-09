import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restful_service/features/book/presentation/book_detail_ui.dart';
import 'package:restful_service/features/book/presentation/book_ui.dart';
import 'package:restful_service/providers.dart';
import 'package:restful_service/routes.dart';

import '../../../stub/stub.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupUITest(context: providersContext, router: router);

  final successResponse = json.decode(stub(path: "book", name: "success"));
  final gateway = bookGatewayProvider.getGateway(providersContext);
  gateway.transport = (request) async {
    return Right(
      RestSuccessResponse(
        data: successResponse,
      ),
    );
  };

  uiTest(
    'should show list of books',
    builder: () => BookUI(),
    verify: mockNetworkImagesFor(
      () => (tester) async {
        final bookItem = find.byType(BookItem);
        expect(bookItem, findsNWidgets(1));
        await tester.pumpAndSettle(const Duration(seconds: 2));
      },
    ),
  );

  // uiTest(
  //   'tapping on book tile should navigate to book detail page',
  //   builder: () => BookUI(),
  //   verify: (tester) async {
  //     // router.to(Routes.book);
  //     await tester.pumpAndSettle();
  //     final bookItem = find.byType(InkWell);
  //     expect(bookItem, findsOneWidget);
  //     await tester.tap(bookItem);
  //     await tester.pumpAndSettle();
  //     // expect(find.byType(BookDetailUI), findsOneWidget);
  //     expect(router.location, '/detail');
  //   },
  // );
}
