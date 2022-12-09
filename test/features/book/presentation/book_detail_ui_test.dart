import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:restful_service/features/book/presentation/book_detail_ui.dart';
import 'package:restful_service/features/book/presentation/book_view_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const viewModel = SingleBookViewModel(
    title: 'title',
    subTitle: 'subtitle',
    isbn: 'isbn',
    price: 'price',
    image: 'image',
    url: 'url',
  );

  testWidgets('Should have a image', (tester) async {
    await mockNetworkImagesFor(
      () async => await tester.pumpWidget(
        const MaterialApp(
          home: BookDetailUI(
            viewModel: viewModel,
          ),
        ),
      ),
    );
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}
