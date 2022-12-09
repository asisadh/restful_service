import 'package:clean_framework/clean_framework_providers.dart';
import 'package:flutter/material.dart';
import 'package:restful_service/features/book/presentation/book_presenter.dart';
import 'package:restful_service/features/book/presentation/book_view_model.dart';
import 'package:restful_service/providers.dart';
import 'package:restful_service/routes.dart';

class BookUI extends UI<BookViewModel> {
  BookUI({super.key});

  @override
  Presenter create(builder) => BookPresenter(
        builder: builder,
        provider: bookUseCaseProvider,
      );

  @override
  Widget build(BuildContext context, BookViewModel viewModel) {
    final numberOfBooks = viewModel.books.length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: ListView.builder(
        itemCount: numberOfBooks,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 120,
            child: BookItem(
              book: viewModel.books[index],
            ),
          );
        },
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  final SingleBookViewModel book;

  const BookItem({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => router.to(
          Routes.bookDetail,
          extra: book,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Row(
            children: [
              SizedBox(
                height: double.maxFinite,
                child: Image.network(
                  book.image,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(5),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        book.subTitle,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'ISBN: ${book.isbn}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Price: ${book.price}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
