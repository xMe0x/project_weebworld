import 'package:flutter/material.dart';
import 'package:project_weebworld/navbarComponent.dart';
import 'package:project_weebworld/post_screen.dart';
import 'package:project_weebworld/tag_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final Map<int, Map<String, Widget>> _navigation = {
    0: {"title": const Text("Home"), "screen": Container()},
    1: {"title": const Text("Search"), "screen": const TagSearchScreen()},
    2: {"title": const Text("Favorite"), "screen": const PostScreen()},
    /* 3: {"title": const Text("Shop"),     "screen": const ShopScreen()},
      4: {"title": const Text("Adiclub"),  "screen": const AdiclubScreen()}, */
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _navigation.values.map((page) => page["screen"]!).toList(),
        ),
        bottomNavigationBar: Navigationmap(
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index; // อัปเดตค่า index ที่เลือก
            });
          },
          selectedIndex: _selectedIndex,
        ),
      ),
      
    );
  }
}
