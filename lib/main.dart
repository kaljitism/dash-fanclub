import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';

import 'config/theme.dart';
import 'ui/dashboard/home_feed.dart';
import 'ui/shop/shop.dart';
import 'ui/chat/chat.dart';
import '../../api/bag.dart';
import 'api/chat_manager.dart';
import 'ui/game/game.dart';
import 'api/game_manager.dart';

GetIt getIt = GetIt.instance;
void main() {
  getIt.registerSingleton<Bag>(Bag());
  getIt.registerSingleton<ChatManager>(ChatManager());
  getIt.registerSingleton<GameManager>(GameManager());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyDash',
      theme: myDashTheme,
      home: const MyHomePage(title: 'MyDash'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _currentWidget = HomeFeed();
  int _currentIndex = 0;
  String _pageTitle = "MyDash";

  void loadScreen() {
    switch (_currentIndex) {
      case 0:
        return setState(() {
          _pageTitle = "MyDash";
          _currentWidget = const HomeFeed();
        });
      case 1:
        return setState(() {
          _pageTitle = "DashShop";
          _currentWidget = const DashShop();
        });
      case 2:
        return setState(() {
          _pageTitle = "DashBot";
          _currentWidget = const Chat();
        });
      case 3:
        return setState(() {
          _pageTitle = "FlappyDash";
          _currentWidget = Game();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.blueGrey[400],
        unselectedLabelStyle: TextStyle(color: Colors.blueGrey[400]),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int tappedIndex) {
          setState(() => {_currentIndex = tappedIndex});
          loadScreen();
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Shop",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flutter_dash),
            label: "FlappyDash",
          ),
        ],
      ),
      body: _currentWidget,
    );
  }
}
