import 'package:flutter/material.dart';

class Navigationmap extends StatefulWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;

  const Navigationmap({super.key, required this.onItemTapped, required this.selectedIndex});

  @override
  State<Navigationmap> createState() => _NavigationmapState();
}

class _NavigationmapState extends State<Navigationmap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, 
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 0.5)), 
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: widget.selectedIndex,
        onTap: (index) {
          widget.onItemTapped(index);
        },
        selectedItemColor: Colors.black, 
        unselectedItemColor: Colors.grey, 
        selectedIconTheme: IconThemeData(
          size: 30,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.house_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "",
          ),
        ],
      ),
    );
  }
}
