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
    'BookUseCase Tests ::',
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
                  .having((e) => e.books[0].toString(), 'Book toSTring',
                      'BookModel{title: Title of book, subtitle: Subtitle of book, isbn: 1234567890,  price: 32.04,  image: https://thatcopy.github.io/catAPI/imgs/webp/60343c6.webp,  url: www.url.com, }')
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
