final class PostAuthor {
  String name;
  String image;

  PostAuthor({required this.name, required this.image});

  PostAuthor.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        image = json['image'];

  Map<String, dynamic> get toJson => {name: 'name', 'image': image};
}
