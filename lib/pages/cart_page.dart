import 'package:flutter/material.dart';
import '../models/cart_model.dart'; // Импортируйте класс Cart

class CartPage extends StatefulWidget {
  final Cart cart; // Добавляем поле для корзины

  CartPage({Key? key, required this.cart}) : super(key: key); // Конструктор

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Корзина',style: TextStyle(
            fontWeight: FontWeight.bold, // Устанавливаем жирный шрифт
            fontSize: 24,),
      ),
      ),
      body: widget.cart.items.isEmpty
          ? Center(child: Text('Корзина пуста'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart.items[index];
                      return _buildCartItem(item);
                    },
                  ),
                ),
                _buildTotalPrice(), // Переместили сюда, чтобы быть под списком
                _buildCheckoutButton(),
              ],
            ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      width: MediaQuery.of(context).size.width - 32, // Адаптивная ширина
      margin: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.service.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '2 дня', // Добавлено описание
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromRGBO(147, 147, 150, 0.867),
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '${item.service.formattedPrice}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(height: 16.0),
            _buildQuantityCounter(item),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityCounter(CartItem item) {
    String getPatientCountText(int quantity) {
      if (quantity % 10 == 1 && quantity % 100 != 11) {
        return '$quantity пациент';
      } else if ((quantity % 10 >= 2 && quantity % 10 <= 4) && (quantity % 100 < 12 || quantity % 100 > 14)) {
        return '$quantity пациента';
      } else {
        return '$quantity пациентов';
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getPatientCountText(item.quantity), // Используем функцию для получения текста
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontFamily: 'Montserrat',
          ),
        ),
        Container(
          height: 32,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.remove, size: 12), // Уменьшенный размер иконки
                padding: EdgeInsets.zero, // Убираем отступы
                constraints: BoxConstraints(), // Убираем ограничения
                onPressed: () {
                  setState(() {
                    if (item.quantity > 1) {
                      item.quantity--;
                    } else {
                      widget.cart.remove(item.service);
                    }
                  });
                },
              ),
              Text(
                                '${item.quantity}', // Отображаем количество
                style: TextStyle(fontSize: 15),
              ),
              IconButton(
                icon: Icon(Icons.add, size: 12), // Уменьшенный размер иконки
                padding: EdgeInsets.zero, // Убираем отступы
                constraints: BoxConstraints(), // Убираем ограничения
                onPressed: () {
                  setState(() {
                    item.quantity++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTotalPrice() {
    double totalPrice = widget.cart.items.fold(0, (sum, item) {
      return sum + (item.service.price * item.quantity);
    });

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white, // Убираем границу, оставляем только цвет фона
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Сумма:', // Изменили текст на "Сумма"
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${totalPrice.toStringAsFixed(2)} ₽', // Форматируем цену
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Логика для перехода к оформлению заказа
          // Например, можно использовать Navigator для перехода на другую страницу
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(26, 111, 238, 1), // Цвет кнопки
          padding: EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Center(
          child: Text(
            'Перейти к оформлению заказа',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
