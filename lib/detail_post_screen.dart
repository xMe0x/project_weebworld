import 'package:flutter/material.dart';
import 'package:project_weebworld/data/postdata.dart';

class PostDetailScreen extends StatelessWidget {
  final Postdata post;

  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            // แสดงรูปโปรไฟล์จาก assets โดยใช้ข้อมูลจาก post.profileImage
            CircleAvatar(
              radius: 20, // ขนาดของรูปโปรไฟล์
              backgroundImage: AssetImage(
                'assets/images/user/${post.profileImage}',
              ), // ใช้ชื่อไฟล์รูปโปรไฟล์จาก Postdata
            ),
            SizedBox(width: 10),
            // แสดงชื่อผู้ใช้
            Text(
              post.username, // ใช้ชื่อผู้ใช้จาก Postdata
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        // backgroundColor: Colors.blueAccent,
      ),
      
      body: Padding(
        
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(

          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // แสดงภาพของโพสต์
              post.image1 != null
                  ? Image.memory(post.image1!, fit: BoxFit.cover)
                  : Image.asset("assets/images/default.png"),

              const SizedBox(height: 20),

              // แสดงหัวข้อของโพสต์
              Text(
                post.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // แสดงเนื้อหาของโพสต์
              Text(post.content, style: TextStyle(fontSize: 16)),

              const SizedBox(height: 20),

              // แสดง hashtag ของโพสต์
              Text(
                post.hashtag,
                style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              ),

              const SizedBox(height: 20),

              // ส่วนแสดงคอมเมนต์
              Text(
                "ความคิดเห็น",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: post.comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person, color: Colors.blueAccent),
                    title: Text(post.comments[index].username), // ชื่อผู้ใช้
                    subtitle: Text(
                      post.comments[index].content,
                    ), // เนื้อหาคอมเมนต์
                  );
                },
              ),

              // การแสดงกล่องแสดงความคิดเห็น
              const SizedBox(height: 20),

              // กล่องข้อความสำหรับแสดงความคิดเห็น
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'แสดงความคิดเห็นกัน!',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // ส่วนไอคอน (จำนวนคนบันทึกแล้ว, like, comment)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // คนบันทึกแล้ว
                    Row(
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '14 คนบันทึกแล้ว',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),

                    // Like (หัวใจ)
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text('50', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(width: 20),

                    // Comment (แสดงความคิดเห็น)
                    Row(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text('1', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
