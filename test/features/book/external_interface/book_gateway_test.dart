import 'dart:convert';

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:clean_framework/clean_framework_providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restful_service/features/book/domain/book_usecase.dart';
import 'package:restful_service/features/book/external_interface/book_gateway.dart';
import 'package:restful_service/providers.dart';

import '../../../stub/stub.dart';

final context = ProvidersContext();

void main() {
  final useCase = UseCaseFake();
  final provider = UseCaseProvider((_) => useCase);

  group('BookGateway Tests', () {
    tearDown(() {
      resetProvidersContext();
    });

    test('fetch books successfully', () async {
      final successResponse = json.decode(stub(path: "book", name: "success"));

      var gateway = BookGateway(context: context, provider: provider);
      gateway.transport = (request) async {
        return Right(
          RestSuccessResponse(
            data: successResponse,
          ),
        );
      };

      await useCase.doFakeRequest(BookGatewayOutput());
      expect(useCase.entity, EntityFake(value: 'success'));
    });

    test('fetch books failed', () async {
      var gateway = BookGateway(context: context, provider: provider);
      gateway.transport = (request) async => Left(UnknownFailureResponse());

      await useCase.doFakeRequest(BookGatewayOutput());
      expect(useCase.entity, EntityFake(value: 'failure'));
    });

    test('Request path', () {
      final testRequest = BookRequest();
      expect(testRequest.path, '1.0/new');
    });
  });
}
