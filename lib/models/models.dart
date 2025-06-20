class Product {
  final int id;
  final String name;
  final int price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}

class User {
  String name;
  String email;
  String phone;
  String birthDate;

  User({
    this.name = "",
    this.email = "",
    this.phone = "",
    this.birthDate = "",
  });

  User copyWith({String? name, String? email, String? phone, String? birthDate}) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
    );
  }

  factory User.fromMap(Map<String, String> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      birthDate: map['birthDate'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'birthDate': birthDate,
    };
  }
}
