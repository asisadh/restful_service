import 'package:clean_framework/clean_framework_providers.dart';
import 'package:flutter/material.dart';
import 'package:restful_service/features/book/domain/book_model.dart';
import 'package:restful_service/features/book/domain/book_usecase.dart';
import 'package:restful_service/features/book/presentation/book_view_model.dart';

class BookPresenter
    extends Presenter<BookViewModel, BookUIOutput, BookUseCase> {
  const BookPresenter({
    super.key,
    required PresenterBuilder<BookViewModel> builder,
    required UseCaseProvider provider,
  }) : super(
          builder: builder,
          provider: provider,
        );

  @override
  void onLayoutReady(BuildContext context, BookUseCase useCase) {
    useCase.fetchBooks();
  }

  @override
  BookViewModel createViewModel(
    BookUseCase useCase,
    BookUIOutput output,
  ) {
    return BookViewModel(
      isLoading: output.isLoading,
      books: output.books
          .map((e) => e.toSingleBookViewModel())
          .toList(growable: false),
      errorMessage: output.errorMessage,
      fetchBooks: useCase.fetchBooks,
    );
  }

  @override
  void onOutputUpdate(BuildContext context, BookUIOutput output) {
    if (output.errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(output.errorMessage)),
      );
    }
  }
}

extension BookInputMappingToSingleBookViewModel on BookInput {
  SingleBookViewModel toSingleBookViewModel() {
    return SingleBookViewModel(
      title: title,
      subTitle: subTitle,
      isbn: isbn,
      price: price,
      image: image,
      url: url,
    );
  }
}
