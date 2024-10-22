class Recipe {
  final String title;
  final String image;
  final String subtitle;
  final String description;
  final String time;
  final double rating;

  Recipe({
    required this.title,
    required this.image,
    required this.subtitle,
    required this.description,
    required this.time,
    required this.rating,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'],
      image: json['image'],
      subtitle: json['subtitle'],
      description: json['description'],
      time: json['time'],
      rating: double.parse(json['rating'].toString().split('/')[0]),
    );
  }
}
