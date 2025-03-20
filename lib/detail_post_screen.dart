import 'package:flutter/material.dart';
import 'package:project_weebworld/data/postdata.dart';

class DetailPostScreen extends StatelessWidget {
  final List<Postdata> posts;

  const DetailPostScreen({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายละเอียดโพสต์"),
      ),
      body: posts.isEmpty
          ? Center(child: Text("ไม่มีโพสต์"))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  elevation: 3,
                  child: ListTile(
                    leading: post.image1 != null
                        ? Image.memory(post.image1!, width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image, size: 50, color: Colors.grey),
                    title: Text(post.title, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(post.content),
                    trailing: Text(post.hashtag, style: TextStyle(color: Colors.blueAccent)),
                  ),
                );
              },
            ),
    );
  }
}
