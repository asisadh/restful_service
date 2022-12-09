import 'package:flutter/material.dart';
import 'package:restful_service/features/book/presentation/book_view_model.dart';

class BookDetailUI extends StatelessWidget {
  const BookDetailUI({
    super.key,
    required this.viewModel,
  });

  final SingleBookViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                viewModel.image,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(height: 5),
              Text(
                viewModel.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                viewModel.subTitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                'ISBN: ${viewModel.isbn}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Price: ${viewModel.price}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
