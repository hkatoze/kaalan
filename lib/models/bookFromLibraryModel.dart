class BookFromLibraryModel {
  int bookId;
  int progress;
  bool isFinish;

  BookFromLibraryModel({
    required this.bookId,
    required this.progress,
    required this.isFinish,
  });

  factory BookFromLibraryModel.fromMap(Map<String, dynamic> map) {
    return BookFromLibraryModel(
      bookId: map['bookId'],
      isFinish: map['isFinish'] == 1,
      progress: map['progress'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookid': bookId,
      'isFinish': isFinish ? 1 : 0,
      'progress': progress,
    };
  }
}
