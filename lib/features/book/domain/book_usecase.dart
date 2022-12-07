import 'package:clean_framework/clean_framework_providers.dart';

import 'book_entity.dart';
import 'book_model.dart';

class BookUseCase extends UseCase<BookEntity> {
  BookUseCase()
      : super(
          entity: BookEntity(),
          outputFilters: {
            BookUIOutput: (BookEntity entity) => BookUIOutput(
                  isLoading: entity.isLoading,
                  books: entity.books,
                  errorMessage: entity.errorMessage,
                ),
          },
        );

  Future<void> fetchBooks() async {
    return debounce(
      action: () async {
        entity = entity.merge(isLoading: true);

        await request<BookGatewayOutput, BookSuccessInput>(
          BookGatewayOutput(),
          onSuccess: (successInput) => entity.merge(
            isLoading: false,
            books: successInput.books,
          ),
          onFailure: (failure) => entity.merge(
            isLoading: false,
            errorMessage: failure.message,
          ),
        );
      },
      tag: 'fetch',
      duration: const Duration(milliseconds: 500),
      immediate: true,
    );
  }
}

class BookUIOutput extends Output {
  BookUIOutput({
    required this.isLoading,
    required this.books,
    required this.errorMessage,
  });

  final bool isLoading;
  final List<BookInput> books;
  final String errorMessage;

  @override
  List<Object?> get props {
    return [
      isLoading,
      books,
      errorMessage,
    ];
  }
}

class BookGatewayOutput extends Output {
  @override
  List<Object?> get props => [];
}

class BookSuccessInput extends SuccessInput {
  final List<BookInput> books;

  BookSuccessInput({required this.books});

  factory BookSuccessInput.fromJson(Map<String, dynamic> json) {
    return BookSuccessInput(
      books: List.of(json['books'] ?? [])
          .map((c) => BookInput.fromJson(c))
          .toList(growable: false),
    );
  }
}
