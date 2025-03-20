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
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
          padding: const EdgeInsets.only(left: 15,top: 10), // ขยับเข้ามาจากซ้าย 10px
          child: Text(
            "WeebWorld",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                color: const Color(0xFFE5EBFC).withOpacity(0.5), // สีพื้นหลังของกล่อง
                 // สีพื้นหลังของกล่อง
              ),
              child: Row(children: [Text('ค้นหา',style: TextStyle(fontSize: 14)
            ),
            SizedBox(width: 110),
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
              _selectedIndex = index; // อัปเดตค่า index ที่เลือก
            });
          },
          selectedIndex: _selectedIndex,
        ),
      ),
      
    );
  }
}