import '../models/service_model.dart';

class Cart {
  final List<CartItem> _items = [];

  void add(Service service) {
    // Проверяем, есть ли уже этот товар в корзине
    final existingItem = _items.firstWhere(
      (item) => item.service.id == service.id,
      orElse: () => CartItem(service: service, quantity: 0), // Возвращаем новый CartItem с количеством 0
    );

    if (existingItem.quantity > 0) {
      // Если товар уже есть, увеличиваем количество
      existingItem.quantity++;
    } else {
      // Если товара нет, добавляем его в корзину
      _items.add(CartItem(service: service, quantity: 1));
    }
  }

  List<CartItem> get items => _items;

  void clear() {
    _items.clear();
  }

  void remove(Service service) {
    _items.removeWhere((item) => item.service.id == service.id);
  }

  double get totalPrice {
    return _items.fold(0.0, (total, item) => total + (item.service.price * item.quantity));

  }

  void decreaseQuantity(Service service) {
    final existingItem = _items.firstWhere(
      (item) => item.service.id == service.id,
      orElse: () => CartItem(service: service, quantity: 0), // Возвращаем новый CartItem с количеством 0
    );

    if (existingItem.quantity > 0) {
      if (existingItem.quantity > 1) {
        existingItem.quantity--;
      } else {
        remove(service);
      }
    }
  }
}

class CartItem {
  final Service service;
  int quantity;

  CartItem({required this.service, required this.quantity});
}
