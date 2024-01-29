import 'package:kaalan/models/bookModel.dart';

class AuthorModel {
  String name;
  String description;
  String profilImg;

  AuthorModel({
    required this.name,
    required this.profilImg,
    required this.description,
  });
  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      name: map['name'],
      description: map['description'],
      profilImg: map['profilImg'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'profilImg': profilImg, 'description': description};
  }
}

class AuthorWithBookModel {
  AuthorModel author;
  List<BookModel> books;
  AuthorWithBookModel({required this.author, required this.books});
  factory AuthorWithBookModel.fromMap(Map<String, dynamic> map) {
    return AuthorWithBookModel(
        author: AuthorModel.fromMap(map['author']),
        books: map['books'].map((book) => BookModel.fromMap(book)).toList());
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'books': books,
    };
  }
}
