class BookModel {
  int id;
  String title;
  String publicationDate;
  String author;
  int nbrPage;
  String description;
  String cover;
  String bookLink;

  BookModel(
      {required this.title,
      required this.id,
      required this.publicationDate,
      required this.author,
      required this.cover,
      required this.description,
      required this.bookLink,
      required this.nbrPage});

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      title: map['title'],
      bookLink: map['bookLink'],
      publicationDate: map['publicationDate'],
      author: map['author'],
      cover: map['cover'],
      description: map['description'],
      nbrPage: map['nbrPage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'publicationDate': publicationDate,
      'author': author,
      'cover': cover,
      'description': description,
      'nbrPage': nbrPage,
      'bookLink': bookLink
    };
  }
}
