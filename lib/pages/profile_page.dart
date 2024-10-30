import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Артем',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 27.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserInfo(),
              _buildMenuOptions(),
              _buildFooterLinks(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 22), // Отступ перед информацией о пользователе
        Text(
          "8-968-228-1337",
          style: TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(137, 138, 141, 1),
          ),
        ),
        SizedBox(height: 16),
        Text(
          "ast@yandex.ru",
          style: TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(137, 138, 141, 1),
          ),
        ),
        SizedBox(height: 48), // Отступ перед меню
      ],
    );
  }

  Widget _buildMenuOptions() {
    return Column(
      children: [
        _buildMenuItem(Icons.list, 'Мои заказы'),
        _buildMenuItem(Icons.card_membership, 'Медицинские карты'),
        _buildMenuItem(Icons.home, 'Мои адреса'),
        _buildMenuItem(Icons.settings, 'Настройки'),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return SizedBox(
      height: 64,
      width: 335,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(height: 24),
        Text(
          "Ответы на вопросы",
          style: TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(147, 147, 150, 100),
          ),
        ),
        SizedBox(height: 24),
        Text(
          "Политика конфиденциальности",
          style: TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(147, 147, 150, 100),
          ),
        ),
        SizedBox(height: 24),
        Text(
          "Пользовательское соглашение",
          style: TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(147, 147, 150, 100),
          ),
        ),
        SizedBox(height: 24),
        Text(
          "Выход",
          style: TextStyle(
            fontSize: 15,
            color: Color.fromRGBO(253, 53, 53, 100),
          ),
        ),
      ],
    );
  }
}
