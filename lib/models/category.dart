class Category {
  int id;
  String name;

  // Construtor da classe Category
  Category({required this.id, required this.name});

  // Fábrica que cria uma instância de Category a partir de um JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }

  // Método que converte uma instância de Category para JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}