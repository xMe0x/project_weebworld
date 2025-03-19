import 'dart:typed_data';
import 'package:flutter/services.dart';

class Postdata {
  final int postId;
  Uint8List? image1;
  final String title;
  final String content;
  final String hashtag;

  static Future<Uint8List> loadAssetImage(String assetPath) async {
    // ถ้า assetPath เริ่มต้นด้วย "assets/" ให้เอาออก
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
    );

    postList.add(newPost);
  }

  // โหลดโพสต์เริ่มต้น (mock data) พร้อมโหลดรูปจาก assets
  static Future<void> loadInitialPosts() async {
    List<Postdata> mockPosts = [
      Postdata(
        postId: 1,
        title: "5 อนิเมะน้ำดีที่ไม่ควรพลาด ถ้าคุณชอบ “Your Name”",
        content: "อนิเมะสนุกๆ ที่คุณต้องดู!",
        hashtag: "#อนิเมะ",
      ),
      Postdata(
        postId: 2,
        title: "นิยายรักสุดฟิน ที่อ่านแล้วใจเต้นแรงกว่าเดิม!",
        content: "นิยายรักที่ต้องอ่าน!",
        hashtag: "#นิยาย",
      ),
      Postdata(
        postId: 3,
        title: "มังงะแนวสืบสวนที่ลุ้นจนหยุดหายใจ 🕵",
        content: "เรื่องราวสุดเข้มข้นแนวโคนัน!",
        hashtag: "#มังงะ",
      ),
      Postdata(
        postId: 4,
        title: "อนิเมะ Slice of Life ที่ดูแล้วเหมือนได้พักใจ",
        content: "อนิเมะ Slice of Life ที่ดูแล้วเหมือนได้พักใจ!",
        hashtag: "#อนิเมะ",
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
      ),
    );
  }

  // ดึงข้อมูลโพสต์ทั้งหมด
  static List<Postdata> getAllPosts() {
    return postList;
  }
}
