import 'package:clean_framework/clean_framework_providers.dart';
import 'package:equatable/equatable.dart';

class BookInput extends Input with EquatableMixin {
  BookInput({
    this.title = '',
    this.subTitle = '',
    this.isbn = '',
    this.price = '',
    this.image = '',
    this.url = '',
  });

  final String title;
  final String subTitle;
  final String isbn;
  final String price;
  final String image;
  final String url;

  factory BookInput.fromJson(Map<String, dynamic> json) {
    return BookInput(
      title: json['title'] ?? '',
      subTitle: json['subtitle'] ?? '',
      isbn: json['isbn13'] ?? '',
      price: json['price'] ?? '',
      image: json['image'] ?? '',
      url: json['url'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        title,
        subTitle,
        isbn,
        price,
        image,
        url,
      ];

  @override
  String toString() {
    return 'BookModel{title: $title, subtitle: $subTitle, isbn: $isbn,  price: $price,  image: $image,  url: $url, }';
  }
}
