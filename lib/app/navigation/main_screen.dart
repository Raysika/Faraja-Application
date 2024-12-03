import 'package:flutter/material.dart';
import 'package:hackathon_frontend/app/app.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ChatbotScreen(),
    const FeaturesScreen(),
    const ProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.chat_bubble_outline),
      label: "ChatBot",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.featured_play_list_outlined),
      label: "Features",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_2_outlined),
      label: "Profile",
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.disabledColor,

      ),
    );
  }
}