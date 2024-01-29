class SearchQueryModel {
  int? id;
  String query;

  SearchQueryModel({
    this.id,
    required this.query,
  });

  factory SearchQueryModel.fromMap(Map<String, dynamic> map) {
    return SearchQueryModel(
      id: map['id'],
      query: map['query'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'query': query,
    };
  }
}
