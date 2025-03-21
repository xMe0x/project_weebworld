import 'package:flutter/material.dart';
import 'package:project_weebworld/data/postdata.dart';
import 'package:project_weebworld/detail_post_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
 State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Postdata> userPosts = [];

  @override
  void initState() {
    super.initState();
    loadUserPosts();
  }

  Future<void> loadUserPosts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? postJsonList = prefs.getStringList("posts");

    if (postJsonList != null && postJsonList.isNotEmpty) {
      setState(() {
        userPosts = postJsonList.map((postJson) {
          Map<String, dynamic> data = jsonDecode(postJson);
          Uint8List? image1;
          if (data["image1"] != null) {
            image1 = base64Decode(data["image1"]);
          }

          return Postdata(
            postId: data["postId"],
            title: data["title"],
            content: data["content"],
            hashtag: data["hashtag"],
            image1: image1,
            username: data["username"],
            profileImage: data["profileImage"],
            comments: List<Comment>.from(
              data["comments"].map(
                (commentJson) => Comment(
                  username: commentJson["username"],
                  content: commentJson["content"],
                ),
              ),
            ),
          );
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "OtakuVerse",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      
        child: Column(
          children: [
         
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("images/user/user2.jpg"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "OtakuVerse",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("สวัสดีชาวคนรักอนิเมะ"),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      profileStat("6", "กำลังติดตาม"),
                      profileStat("0", "ผู้ติดตาม"),
                      profileStat("1", "ถูกใจและบันทึก"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                ],
              ),
            ),

       
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(icon: Icon(Icons.grid_on)),
                      Tab(icon: Icon(Icons.bookmark_border)),
                    ],
                  ),
                  Container(
                    height: 400,
                    child: TabBarView(
                      children: [
                        userPosts.isEmpty
                            ? Center(child: Text("ยังไม่มีโพสต์"))
                            : GridView.builder(
                                padding: EdgeInsets.all(10),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: userPosts.length,
                                itemBuilder: (context, index) {
                                  return postCard(userPosts[index]);
                                },
                              ),

                        Center(child: Text("ยังไม่มีบุ๊คมาร์ค")),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileStat(String count, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }


Widget postCard(Postdata post) {
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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: post.image1 != null
                ? Image.memory(post.image1!, fit: BoxFit.cover, width: double.infinity)
                : Container(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(post.content, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ),
  );
}
}
