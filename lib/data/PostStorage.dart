import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'postdata.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

class PostStorage {

  static Future<void> savePosts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> postJsonList = Postdata.postList.map((post) {
      return jsonEncode({
        "postId": post.postId,
        "title": post.title,
        "content": post.content,
        "hashtag": post.hashtag,
        "image1": post.image1 != null ? base64Encode(post.image1!) : null,
        "username": post.username,
        "profileImage": post.profileImage,
        "comments": post.comments.map((comment) => {
          "username": comment.username,
          "content": comment.content,
        }).toList(),
      });
    }).toList();

    debugPrint("กำลังบันทึกโพสต์ลง SharedPreferences: ${postJsonList.length} รายการ");
    await prefs.setStringList("posts", postJsonList);
  }


  static Future<void> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? postJsonList = prefs.getStringList("posts");

    if (postJsonList != null && postJsonList.isNotEmpty) {
      debugPrint("พบข้อมูลโพสต์ที่บันทึกไว้: ${postJsonList.length} รายการ");

      Postdata.postList = postJsonList.map((postJson) {
        Map<String, dynamic> data = jsonDecode(postJson);
        Uint8List? image1;

        if (data["image1"] != null) {
          image1 = base64Decode(data["image1"]);
        }


        List<Comment> comments = [];
        if (data["comments"] != null) {
          comments = List<Comment>.from(
            data["comments"].map((commentData) => Comment(
              username: commentData["username"],
              content: commentData["content"],
            )),
          );
        }

        return Postdata(
          postId: data["postId"],
          title: data["title"],
          content: data["content"],
          hashtag: data["hashtag"],
          image1: image1,
          username: data["username"],
          profileImage: data["profileImage"],
          comments: comments,
        );
      }).toList();

      debugPrint("โหลดข้อมูลโพสต์สำเร็จ: ${Postdata.getAllPosts().length} รายการ");
    } else {
      debugPrint("ไม่พบข้อมูลโพสต์ใน SharedPreferences");
      // โหลด mock data และบันทึก
      await Postdata.loadInitialPosts();
      await savePosts();
      debugPrint("โหลด mock posts และบันทึกลง SharedPreferences");
    }
  }


  static Future<Postdata?> getPostById(int id) async {
    await loadPosts();
    return Postdata.getAllPosts().firstWhere(
      (post) => post.postId == id,
      orElse: () => Postdata(
        postId: -1,
        title: "ไม่พบโพสต์",
        content: "โพสต์นี้ไม่มีอยู่ในระบบ",
        hashtag: "#ไม่พบข้อมูล",
        image1: null,
        username: "ไม่มีชื่อผู้ใช้",
        profileImage: "default.jpg",
        comments: [],
      ),
    );
  }
}
