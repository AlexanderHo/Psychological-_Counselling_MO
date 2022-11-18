class NewsModel {
  final int id;
  final String urlBanner;
  final String title;
  final String description;
  final String createDay;
  final String contentNews;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createDay,
    required this.contentNews,
    required this.urlBanner,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int,
      title: json['title'],
      description: json['description'],
      createDay: json['createDay'],
      contentNews: json['contentNews'],
      urlBanner: json['urlBanner'],
    );
  }
  NewsModel.general({
    required this.id,
    required this.title,
    required this.urlBanner,
  })  : contentNews = '',
        description = '',
        createDay = '';

  factory NewsModel.fromGeneralJson(Map<String, dynamic> json) {
    return NewsModel.general(
      id: json['id'] as int,
      title: json['title'] as String,
      urlBanner: json['urlBanner'] as String,
    );
  }
}
