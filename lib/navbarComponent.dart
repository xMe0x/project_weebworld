import 'package:flutter/material.dart';

class Navigationmap extends StatefulWidget {
  final Function(int) onItemTapped; // เพิ่ม callback function
  final int selectedIndex; // รับค่าปัจจุบัน

  const Navigationmap({super.key, required this.onItemTapped, required this.selectedIndex});

  @override
  State<Navigationmap> createState() => _Navigationmap();
}
  class _Navigationmap extends State<Navigationmap>{


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        currentIndex: widget.selectedIndex, // ใช้ค่าจาก HomeScreen
      onTap: (index) {
        widget.onItemTapped(index); // ส่งค่าไปที่ HomeScreen
      },
      selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
      selectedIconTheme: IconThemeData(
        size: 30,
      ),
      unselectedItemColor: const Color.fromARGB(255, 35, 81, 233),
      items: [
         const BottomNavigationBarItem(
          icon: Icon(Icons.house_outlined),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none_outlined),
          label: "",
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "",
        ),
      ],
    );
  }
}
