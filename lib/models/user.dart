class UserModel {
  String? name;
  String? uId;
  String? phone;
  String email;
  String password;
  String? bio;
  String? image;
  String? cover;

  UserModel({
    this.name,
    this.phone,
    required this.email,
    required this.password,
    this.bio,
    this.cover,
    this.image,
    this.uId
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
        email = json['email'],
        password = json['password'],
        bio = json['bio'],
        image = json['image'],
        uId = json['uId'],
        cover = json['cover'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'bio': bio,
        'image': image,
        'cover': cover,
        'uId' : uId,
      };

  @override
  String toString() =>
      'User : name : $name , phone : $phone , email : $email , password : $password';
}
