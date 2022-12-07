import 'package:clean_framework/clean_framework_providers.dart';

class BookViewModel extends ViewModel {
  const BookViewModel({
    required this.isLoading,
    required this.books,
    required this.errorMessage,
    required this.fetchBooks,
  });

  final bool isLoading;
  final List<SingleBookViewModel> books;
  final String errorMessage;

  final Future<void> Function() fetchBooks;

  @override
  List<Object?> get props => [
        isLoading,
        books,
        errorMessage,
      ];
}

class SingleBookViewModel extends ViewModel {
  const SingleBookViewModel({
    required this.title,
    required this.subTitle,
    required this.isbn,
    required this.price,
    required this.image,
    required this.url,
  });

  final String title;
  final String subTitle;
  final String isbn;
  final String price;
  final String image;
  final String url;

  @override
  List<Object?> get props => [
        title,
        subTitle,
        isbn,
        price,
        image,
        url,
      ];
}
