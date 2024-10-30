import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/service_model.dart';
import '../models/cart_model.dart'; // Импортируйте класс Cart
import 'cart_page.dart'; // Импортируйте страницу корзины

class ServicesPage extends StatefulWidget {
  final Cart cart; // Добавляем поле для корзины

  // Конструктор, который принимает экземпляр корзины
  ServicesPage({Key? key, required this.cart}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<Service> services = [];

  @override
  void initState() {
    super.initState();
    loadServices();
  }

  Future<void> loadServices() async {
    final String response = await rootBundle.loadString('assets/services.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      services = data.map((service) => Service.fromJson(service)).toList();
    });
  }

  void addToCart(Service service) {
    widget.cart.add(service); // Используем переданный экземпляр корзины
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${service.title} добавлено в корзину')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Каталог услуг',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
      ),
      body: services.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: services.length,
              itemBuilder: (context, index) {
                return ServiceCard(
                  service: services[index],
                  onAddToCart: addToCart, // Передаем функцию добавления в корзину
                );
              },
            ),
    );
  }
}

// Остальной код (ServiceCard) остается без изменений


class ServiceCard extends StatelessWidget {
  final Service service;
  final Function(Service) onAddToCart; // Функция для добавления в корзину

  const ServiceCard({Key? key, required this.service, required this.onAddToCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 136,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    service.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromRGBO(147, 147, 150, 0.867),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    '${service.price} ₽',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  onAddToCart(service); // Вызываем функцию добавления в корзину
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A6FEE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Добавить', // Текст кнопки
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
