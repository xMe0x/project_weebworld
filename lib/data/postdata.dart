import 'dart:typed_data';
import 'package:flutter/services.dart';

class Postdata {
  final int postId;
  Uint8List? image1;
  final String title;
  final String content;
  final String hashtag;
  final String username; // เพิ่มข้อมูลผู้ใช้
  final String profileImage; // เพิ่มข้อมูลรูปโปรไฟล์ผู้ใช้
  final List<Comment> comments;  // เพิ่มตัวแปรคอมเมนต์
  

  static Future<Uint8List> loadAssetImage(String assetPath) async {
    String correctedPath = assetPath.startsWith("assets/") ? assetPath.substring(7) : assetPath;
    ByteData data = await rootBundle.load("assets/" + correctedPath);
    return data.buffer.asUint8List();
  }

  // Static List สำหรับเก็บโพสต์ทั้งหมด
  static List<Postdata> postList = [];

  Postdata({
    required this.postId,
    this.image1,
    required this.title,
    required this.content,
    required this.hashtag,
    required this.username, // เพิ่มตัวแปรใน constructor
    required this.profileImage, // เพิ่มตัวแปรใน constructor
    required this.comments,  // รับค่า comments
  });

  

  // เพิ่มโพสต์ใหม่ลงใน List (ถ้าไม่มีรูป ให้โหลด default จาก assets)
  static Future<void> addPost(Postdata post) async {
    int newId = postList.isEmpty ? 1 : postList.last.postId + 1;
    Uint8List image = post.image1 ?? await loadAssetImage("assets/images/default.png");

    Postdata newPost = Postdata(
      postId: newId,
      title: post.title,
      content: post.content,
      hashtag: post.hashtag,
      image1: image,
      username: post.username, // เพิ่มข้อมูลผู้ใช้
      profileImage: post.profileImage, // เพิ่มรูปโปรไฟล์
      comments: post.comments, // เพิ่มข้อมูลคอมเมนต์
    );

    postList.add(newPost);
  }

  // โหลดโพสต์เริ่มต้น (mock data) พร้อมโหลดรูปจาก assets
  static Future<void> loadInitialPosts() async {
    List<Postdata> mockPosts = [
      Postdata(
        postId: 1,
        title: "5 อนิเมะน้ำดีที่ไม่ควรพลาด ถ้าคุณชอบ “Your Name”",
        content: "ถ้าคุณชอบ Your Name (Kimi no Na wa)\nแล้วอยากหาอนิเมะแนวคล้ายกันที่ให้ความรู้สึกสุดซึ่ง ประทับใจ และภาพสวยละมุน💖 \nวันนี้เราขอแนะนำ 5 อนิเมะน้ำดีที่คุณไม่ควรพลาด! \n\n1.",
        hashtag: "#อนิเมะ",
        username: "admin0", // เพิ่มชื่อผู้ใช้
        profileImage: "user1.jpg", // เพิ่มรูปโปรไฟล์
        comments: [
          Comment(username: "AnimeLover99", content: "ดู Weathering With You แล้วน้ำตาแตกจริง! ใครยังไม่ได้ดูแนะนำเลยค่ะ"),
          Comment(username: "OtakuHeart", content: "ชอบ I Want to Eat Your Pancreas มาก! แต่ชื่อเรื่องทำเอาคนเข้าใจผิดตลอด 555"),
  ], // เพิ่มคอมเมนต์ใหม่
      ),
      Postdata(
        postId: 2,
        title: "นิยายรักสุดฟิน ที่อ่านแล้วใจเต้นแรงกว่าเดิม!",
        content: "นิยายรักที่ต้องอ่าน!",
        hashtag: "#นิยาย",
        username: "admin0", // เพิ่มชื่อผู้ใช้
        profileImage: "user1.jpg", // เพิ่มรูปโปรไฟล์
        comments: [
          Comment(username: "user1", content: "ความคิดเห็นแรก"),
          Comment(username: "user2", content: "ความคิดเห็นที่สอง"),
  ], // เพิ่มคอมเมนต์ใหม่
      ),
      Postdata(
        postId: 3,
        title: "มังงะแนวสืบสวนที่ลุ้นจนหยุดหายใจ 🕵",
        content: "เรื่องราวสุดเข้มข้นแนวโคนัน!",
        hashtag: "#มังงะ",
        username: "admin0", // เพิ่มชื่อผู้ใช้
        profileImage: "user1.jpg", // เพิ่มรูปโปรไฟล์
        comments: [
          Comment(username: "user1", content: "ความคิดเห็นแรก"),
          Comment(username: "user2", content: "ความคิดเห็นที่สอง"),
  ], // เพิ่มคอมเมนต์ใหม่
      ),
      Postdata(
        postId: 4,
        title: "อนิเมะ Slice of Life ที่ดูแล้วเหมือนได้พักใจ",
        content: "อนิเมะ Slice of Life ที่ดูแล้วเหมือนได้พักใจ!",
        hashtag: "#อนิเมะ",
        username: "admin0", // เพิ่มชื่อผู้ใช้
        profileImage: "user1.jpg", // เพิ่มรูปโปรไฟล์
        comments: [
          Comment(username: "user1", content: "ความคิดเห็นแรก"),
          Comment(username: "user2", content: "ความคิดเห็นที่สอง"),
  ], // เพิ่มคอมเมนต์ใหม่
      ),
    ];

    List<String> imagePaths = [
      "assets/images/post/post1.png",
      "assets/images/post/post2.png",
      "assets/images/post/post3.png",
      "assets/images/post/post4.png",
    ];

    // โหลดรูปทั้งหมดพร้อมกัน
    List<Uint8List> images = await Future.wait(
      imagePaths.map((path) => loadAssetImage(path)),
    );

    for (int i = 0; i < mockPosts.length; i++) {
      mockPosts[i].image1 = images[i];
    }

    postList = mockPosts;
  }

  // ดึงโพสต์ตาม ID
  static Postdata? getPostById(int id) {
    return postList.firstWhere(
      (post) => post.postId == id,
      orElse: () => Postdata(
        postId: -1,
        title: "ไม่พบโพสต์",
        content: "โพสต์ที่คุณกำลังมองหาไม่มีอยู่ในระบบ",
        hashtag: "#ไม่พบข้อมูล",
        image1: null, 
        username: '', 
        profileImage: '', comments: [],
      ),
    );
  }

  // ดึงข้อมูลโพสต์ทั้งหมด
  static List<Postdata> getAllPosts() {
    return postList;
  }
}

class Comment {
  final String username;
  final String content;

  Comment({required this.username, required this.content});
}
