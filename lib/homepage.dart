import 'package:flutter/material.dart';
import 'package:project_weebworld/detail_post_screen.dart';
import 'package:project_weebworld/navbarComponent.dart';
import 'package:project_weebworld/data/PostStorage.dart';
import 'package:project_weebworld/data/postdata.dart';
/* import 'dart:typed_data'; */

class Homepage extends StatefulWidget {
  const  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Postdata>> _posts; 

  @override
  void initState() {
    super.initState();
    _posts = _loadPosts(); // โหลดโพสต์ตอนเริ่มต้นแอป
  }

  // ฟังก์ชันโหลดโพสต์จาก SharedPreferences
  Future<List<Postdata>> _loadPosts() async {
    await PostStorage.loadPosts(); 
    return Postdata.getAllPosts(); 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      home: Scaffold(
        backgroundColor: Colors.white,
      
        body: FutureBuilder<List<Postdata>>(
          future: _posts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {

              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
          
              return Center(child: Text("Error loading posts"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {

              return Center(child: Text("No posts available"));
            }

            final posts = snapshot.data!; // ดึงโพสต์ทั้งหมดที่โหลดมาได้

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                
                itemCount: posts.length, // จำนวนโพสต์ทั้งหมด
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // แสดง 2 คอลัมน์
                  crossAxisSpacing: 10, 
                  mainAxisSpacing: 10, 
                  childAspectRatio: 0.75, 
                ),
                itemBuilder: (context, index) {
                  return _buildPostCard(posts[index]); // สร้างการ์ดแต่ละโพสต์
                },
              ),
            );
          },
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างการ์ดโพสต์แต่ละอัน
 Widget _buildPostCard(Postdata post) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PostDetailScreen(post: post),
        ),
      );
    },
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // แสดงรูปภาพของโพสต์
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: post.image1 != null
                ? Image.memory(
                    post.image1!,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 120,
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.image, size: 40, color: Colors.grey[600])),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("admin", style: TextStyle(color: Colors.grey, fontSize: 12)),
                Row(
                  children: [
                    Icon(Icons.favorite, size: 16, color: Colors.red),
                    SizedBox(width: 4),
                    Text("107", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}