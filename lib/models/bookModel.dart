class BookModel {
  String title;
  String publicationDate;
  String author;
  int nbrPage;
  String description;
  String cover;
  double apreciationStar;
  double readQty;

  BookModel(
      {required this.title,
      required this.publicationDate,
      required this.author,
      required this.cover,
      required this.description,
      required this.apreciationStar,
      required this.readQty,
      required this.nbrPage});
}
