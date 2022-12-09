import 'package:clean_framework/clean_framework_providers.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restful_service/features/book/domain/book_model.dart';
import 'package:restful_service/features/book/domain/book_usecase.dart';
import 'package:restful_service/features/book/presentation/book_presenter.dart';
import 'package:restful_service/features/book/presentation/book_view_model.dart';

void main() {
  testWidgets('LastLoginIsoDatePresenter ::', (tester) async {
    final useCase = BookUseCaseFake(
        BookUIOutput(isLoading: false, books: const [], errorMessage: ''));

    final provider = UseCaseProvider((_) => useCase);

    await ProviderTester().pumpWidget(
      tester,
      MaterialApp(
        home: BookPresenter(
          builder: (viewModel) {
            expect(
                viewModel,
                BookViewModel(
                    isLoading: false,
                    books: const [],
                    errorMessage: '',
                    fetchBooks: (() async {})));
            return const Text('Book UI');
          },
          provider: provider,
        ),
      ),
    );
    await tester.pumpAndSettle();
    // usecase Invoked
    expect(useCase.isCallbackInvoked, isTrue);
  });

  test('BookInputMappingToSingleBookViewModel ::', () {
    final bookInput = BookInput(
      title: 'title',
      subTitle: 'subtitle',
      isbn: 'isbn',
      price: 'price',
      image: 'image',
      url: 'url',
    );

    const result = SingleBookViewModel(
      title: 'title',
      subTitle: 'subtitle',
      isbn: 'isbn',
      price: 'price',
      image: 'image',
      url: 'url',
    );

    expect(result, bookInput.toSingleBookViewModel());
  });
}

class BookUseCaseFake extends BookUseCase {
  final Output output;
  bool isCallbackInvoked = false;

  BookUseCaseFake(this.output);

  @override
  Future<void> fetchBooks() async {
    isCallbackInvoked = true;
  }

  @override
  O getOutput<O extends Output>() {
    return output as O;
  }
}
