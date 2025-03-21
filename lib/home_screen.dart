import 'package:flutter/material.dart';
import 'package:project_weebworld/homepage.dart';
import 'package:project_weebworld/navbarComponent.dart';
import 'package:project_weebworld/notification.dart';
import 'package:project_weebworld/post_screen.dart';
import 'package:project_weebworld/profile.dart';
import 'package:project_weebworld/tag_search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final Map<int, Map<String, Widget>> _navigation = {
    0: {"title": const Text("Home"), "screen": Homepage()},
    1: {"title": const Text("Search"), "screen": TagSearchScreen()},
    2: {"title": const Text("Favorite"), "screen": const PostScreen()},
    3: {"title": const Text("notification"), "screen": const NotificationPage()},
    4: {"title": const Text("profile"), "screen": const Profile()},
  };

  final List<int> _hideAppBarScreens = [2,3,4];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, 
          selectedItemColor: Colors.black, 
          unselectedItemColor: Colors.grey, 
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: _hideAppBarScreens.contains(_selectedIndex)
            ? null
            : AppBar(
                backgroundColor: Colors.white,
                title: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Text(
                    "WeebWorld",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Container(
                      width: 200,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54, width: 0.5),
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xFFE5EBFC).withOpacity(0.5),
                      ),
                      child: Row(
                        children: [
                          Text('ค้นหา', style: TextStyle(fontSize: 14)),
                          Spacer(),
                          Icon(Icons.search, color: Colors.black54),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _navigation.values.map((page) => page["screen"]!).toList(),
        ),
        bottomNavigationBar: Navigationmap(
          onItemTapped: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }
}
