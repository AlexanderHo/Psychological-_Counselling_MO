class PlanetModel {
  final int id;
  final String imageUrl;
  final String name;
  final String tag;
  final String? element;
  final String description;
  final String mainContent;

  PlanetModel(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.tag,
      required this.element,
      required this.description,
      required this.mainContent});

  factory PlanetModel.fromJson(Map<String, dynamic> json) {
    return PlanetModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      element: json['element'] as String?,
      tag: json['tag'] as String,
      description: json['description'] as String,
      mainContent: json['maincontent'] as String,
    );
  }

  PlanetModel.general(
      {required this.id, required this.name, required this.imageUrl})
      : element = '',
        tag = '',
        mainContent = '',
        description = '';

  factory PlanetModel.fromGeneralJson(Map<String, dynamic> json) {
    return PlanetModel.general(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      // description: json['description'] as String,
    );
  }
}
