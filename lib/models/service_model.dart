class Service {
  final String id; // Уникальный идентификатор
  final String title;
  final String description;
  final double price;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'], // Инициализация поля id
      title: json['title'],
      description: json['description'],
      price: double.parse(json['price']), // Преобразуем строку в double
    );
  }

  // Метод для форматирования цены с символом рубля
  String get formattedPrice {
    return '${price.toStringAsFixed(2)} ₽'; // Форматируем цену до двух знаков после запятой и добавляем символ рубля
  }
}
