import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:clean_framework/clean_framework_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restful_service/features/book/domain/book_entity.dart';
import 'package:restful_service/providers.dart';

import '../../../stub/stub.dart';

void main() {
  setUp(() {
    resetProvidersContext();
  });

  group(
    'BookUseCase Tests',
    (() {
      test('fetch books successfully', () async {
        final useCase =
            bookUseCaseProvider.getUseCaseFromContext(providersContext);
        final gateway = bookGatewayProvider.getGateway(providersContext);
        final successResponse =
            json.decode(stub(path: "book", name: "success"));

        gateway.transport = (request) async {
          return Right(
            RestSuccessResponse(
              data: successResponse,
            ),
          );
        };

        expect(useCase.entity, BookEntity());

        expectLater(
          useCase.stream,
          emitsInOrder(
            [
              BookEntity(isLoading: true),
              isA<BookEntity>()
                  .having((e) => e.isLoading, 'isLoading', false)
                  .having(
                      (e) => e.books[0].title, 'Title of book', 'Title of book')
            ],
          ),
        );

        await useCase.fetchBooks();
        useCase.dispose();
      });

      test('fetch books failed', () async {
        final useCase =
            bookUseCaseProvider.getUseCaseFromContext(providersContext);
        final gateway = bookGatewayProvider.getGateway(providersContext);

        gateway.transport = (request) async {
          return Left(UnknownFailureResponse());
        };

        expectLater(
          useCase.stream,
          emitsInOrder(
            [
              BookEntity(isLoading: true),
              BookEntity(
                isLoading: false,
                errorMessage: 'Something went wrong',
              ),
            ],
          ),
        );

        await useCase.fetchBooks();
        useCase.dispose();
      });
    }),
  );
}
