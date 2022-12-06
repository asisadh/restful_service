import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:clean_framework/clean_framework_providers.dart';
import 'package:restful_service/features/book/domain/book_usecase.dart';
import 'package:restful_service/providers.dart';

class BookGateway
    extends RestGateway<BookGatewayOutput, BookRequest, BookSuccessInput> {
  BookGateway()
      : super(
          context: providersContext,
          provider: bookUseCaseProvider,
        );

  @override
  BookRequest buildRequest(BookGatewayOutput output) {
    return BookRequest();
  }

  @override
  BookSuccessInput onSuccess(covariant RestSuccessResponse<Object> response) {
    return BookSuccessInput.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  FailureInput onFailure(FailureResponse failureResponse) {
    return FailureInput(message: 'Something went wrong');
  }
}

class BookRequest extends GetRestRequest {
  @override
  String get path => '1.0/new';
}
