import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restful_service/features/book/domain/book_entity.dart';
import 'package:restful_service/features/book/domain/book_model.dart';
import 'package:restful_service/providers.dart';

import '../../../stub/stub.dart';

void main() {
  final testConstant = [
    BookInput(
        title: "Title of book",
        subTitle: "Subtitle of book",
        isbn: "1234567890",
        price: "32.04",
        image: "image.jpg",
        url: "www.url.com")
  ];

  group('BookGateway Tests', () {
    tearDown(() {
      resetProvidersContext();
    });

    test('fetch books successfully', () async {
      final useCase = bookUseCaseProvider.getUseCaseFromContext(
        providersContext,
      );

      final gateway = bookGatewayProvider.getGateway(providersContext);

      final successResponse = json.decode(stub(path: "book", name: "success"));

      gateway.transport = (request) async {
        return Right(
          RestSuccessResponse(
            data: successResponse,
          ),
        );
      };

      expect(
        useCase.stream,
        emitsInOrder(
          [
            BookEntity(isLoading: true),
            BookEntity(
              isLoading: false,
              books: testConstant,
            ),
          ],
        ),
      );

      await useCase.fetchBooks();
      useCase.dispose();
    });
  });
}
