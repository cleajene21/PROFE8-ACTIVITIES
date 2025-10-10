class Camera {
  final String id;
  final String name;
  final String brand;
  final String imageUrl;
  final double pricePerDay;
  final List<String> features;
  final bool isAvailable;
  final double rating;
  final String category;

  Camera({
    required this.id,
    required this.name,
    required this.brand,
    required this.imageUrl,
    required this.pricePerDay,
    required this.features,
    required this.isAvailable,
    required this.rating,
    required this.category,
  });
}
