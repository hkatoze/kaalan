class CategoryModel {
  String name;
  String icon;
  int id;

  CategoryModel({required this.name, required this.id,required this.icon});

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'],
      icon: map['icon'],
      id: map['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'id': id,
    };
  }
}
