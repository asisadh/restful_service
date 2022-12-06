import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:restful_service/features/book/domain/book_entity.dart';
import 'package:restful_service/features/book/domain/book_usecase.dart';
import 'package:restful_service/features/book/external_interface/book_gateway.dart';

ProvidersContext _providersContext = ProvidersContext();

ProvidersContext get providersContext => _providersContext;

@visibleForTesting
void resetProvidersContext([ProvidersContext? context]) {
  _providersContext = context ?? ProvidersContext();
}

final bookUseCaseProvider = UseCaseProvider<BookEntity, BookUseCase>(
  (_) => BookUseCase(),
);

final bookGatewayProvider = GatewayProvider<BookGateway>(
  (_) => BookGateway(),
);
