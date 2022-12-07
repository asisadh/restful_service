import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
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

  group('book UI tests ::', () {
    // mockNetworkImagesFor(() {
    // uiTest('should show list of books',
    //     builder: () => BookUI(),
    //     verify: (tester) async {
    //       final bookItem = find.byType(BookItem);
    //       expect(bookItem, findsNWidgets(1));
    //     });
  });
  // });
}
