import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();


}
class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('การแจ้งเตือน'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('images/user/user2.jpg'), // ใส่รูปโปรไฟล์
            ),
            title: Text(
              'AnimeLover99',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('ถูกใจโพสต์ของคุณ 10 ชม.'),
            trailing: Image.asset(
              'images/post/post1.png', // ใส่รูปตัวอย่างโพสต์
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            onTap: () {
              // กำหนดให้เมื่อแตะแล้วไปยังโพสต์ที่ถูกไลก์
            },
          ),
        ],
      ),
    );
  }
}
