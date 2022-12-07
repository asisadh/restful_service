import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:restful_service/features/book/presentation/book_detail_ui.dart';
import 'package:restful_service/features/book/presentation/book_ui.dart';
import 'package:restful_service/features/book/presentation/book_view_model.dart';

enum Routes {
  book,
  bookDetail,
}

final router = AppRouter<Routes>(
  routes: [
    AppRoute(
      name: Routes.book,
      path: '/',
      builder: (context, state) => BookUI(),
      routes: [
        AppRoute(
          name: Routes.bookDetail,
          path: 'detail',
          builder: (context, state) => BookDetailUI(
            viewModel: state.extra as SingleBookViewModel,
          ),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Page404(error: state.error),
);

class Page404 extends StatelessWidget {
  const Page404({Key? key, required this.error}) : super(key: key);

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(error.toString()),
      ),
    );
  }
}
