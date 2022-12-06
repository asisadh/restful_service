import 'package:clean_framework/clean_framework_providers.dart';
import 'package:restful_service/features/book/book_model.dart';

class BookEntity extends Entity {
  BookEntity({
    this.isLoading = false,
    this.books = const [],
    this.errorMessage = '',
  });

  final bool isLoading;
  final List<BookInput> books;
  final String errorMessage;

  @override
  List<Object?> get props => [
        isLoading,
        books,
        errorMessage,
      ];

  BookEntity merge({
    bool? isLoading,
    List<BookInput>? books,
    String? errorMessage,
  }) {
    return BookEntity(
      isLoading: isLoading ?? this.isLoading,
      books: books ?? this.books,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
