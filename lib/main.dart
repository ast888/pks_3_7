import 'package:flutter/material.dart';
import 'pages/services_page.dart';
import 'pages/cart_page.dart';
import 'pages/profile_page.dart';
import 'models/cart_model.dart'; // Импортируйте класс Cart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat', // Установка шрифта по умолчанию
        scaffoldBackgroundColor: Colors.white, // Устанавливаем белый фон для всего приложения
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false, // Убираем баннер отладки
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final Cart cart = Cart(); // Создаем экземпляр корзины
  late final List<Widget> _pages; // Объявляем список _pages

  @override
  void initState() {
    super.initState();
    // Инициализируем список _pages в методе initState
    _pages = [
      ServicesPage(cart: cart), // Передаем экземпляр корзины в ServicesPage
      CartPage(cart: cart), // Передаем экземпляр корзины в CartPage
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
