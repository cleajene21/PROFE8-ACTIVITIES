class User {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final List<String> favoritesCameraIds;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.favoritesCameraIds,
  });
}
