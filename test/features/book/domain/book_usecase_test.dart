import 'package:flutter_test/flutter_test.dart';
import 'package:restful_service/features/book/domain/book_entity.dart';
import 'package:restful_service/features/book/domain/book_usecase.dart';
import 'package:restful_service/providers.dart';

void main() {
  BookUseCase getBookUseCase() {
    return bookUseCaseProvider.getUseCaseFromContext(
      providersContext,
    );
  }

  setUp(() {
    resetProvidersContext();
  });

  group(
    'BookUseCase Tests',
    (() {
      test(
        'fetch books successfully',
        () async {
          final useCase = getBookUseCase();

          expect(useCase.entity, BookEntity());

          await useCase.fetchBooks();
          useCase.dispose();
        },
      );
    }),
  );
}
