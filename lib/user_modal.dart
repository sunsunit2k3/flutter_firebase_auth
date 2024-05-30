import 'dart:convert';

class Users {
  final String name;
  final String age;
  Users(
    this.name,
    this.age,
  );

  Users copyWith({
    String? name,
    String? age,
  }) {
    return Users(
      name ?? this.name,
      age ?? this.age,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      map['name'] ?? '',
      map['age'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() => 'Users(name: $name, age: $age)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users && other.name == name && other.age == age;
  }

  @override
  int get hashCode => name.hashCode ^ age.hashCode;
}
