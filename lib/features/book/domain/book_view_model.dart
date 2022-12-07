import 'package:clean_framework/clean_framework_providers.dart';

import 'book_model.dart';

class BookViewModel extends ViewModel {
  const BookViewModel({
    required this.isLoading,
    required this.books,
    required this.errorMessage,
    required this.fetchBooks,
  });

  final bool isLoading;
  final List<BookInput> books;
  final String errorMessage;

  final Future<void> Function() fetchBooks;

  @override
  List<Object?> get props => [
        isLoading,
        books,
        errorMessage,
      ];
}
