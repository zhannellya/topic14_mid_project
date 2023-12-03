class City {
  final String description;
  final String placeId;

  City({
    required this.description,
    required this.placeId,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      description: json['description'] ?? '',
      placeId: json['place_id'] ?? '',
    );
  }

  @override
  String toString() => '''
    Description: $description
    Place ID: $placeId
  ''';

  static getLocationfromJson(Map<String, dynamic> jsonResponse) {}
}
