 
class NewsModel {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String publishedAt;

  NewsModel(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.content,
      required this.publishedAt});

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      author: "${map['author']}",
      title: "${map['title']}",
      description: "${map['description']}",
      url: "${map['url']}",
      content: "${map['content']}",
      urlToImage: "${map['urlToImage']}",
      publishedAt: "${map['publishedAt']}",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': "${author}",
      'title': "${title}",
      'description': "${description}",
      'url': "${url}",
      'content': "${content}",
      'urlToImage': "${urlToImage}",
      'publishedAt': "{$publishedAt}"
    };
  }
}

