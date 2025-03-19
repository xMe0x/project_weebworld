import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:project_weebworld/data/postdata.dart';
import 'package:project_weebworld/data/PostStorage.dart';
import 'package:project_weebworld/result_search_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _hashtagController = TextEditingController();

  Uint8List? _imageBytes1;

  // ฟังก์ชันเลือกรูปภาพ
  Future<void> _pickImage(int imageNumber) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        if (imageNumber == 1) {
          _imageBytes1 = imageBytes;
        }
      });
    }
  }

  // ฟังก์ชันเพิ่ม # ให้กับแฮชแท็ก
  void _addHashtag() {
    setState(() {
      if (_hashtagController.text.isNotEmpty &&
          !_hashtagController.text.startsWith('#')) {
        _hashtagController.text = '#' + _hashtagController.text;
      } else if (_hashtagController.text.isEmpty) {
        _hashtagController.text = '#';
      }
    });
  }

  // ฟังก์ชันกดปุ่มโพสต์ 
  Future<void> _submitPost() async {
    if (_formKey.currentState!.validate()) {
      int newId = Postdata.postList.isEmpty ? 1 : Postdata.postList.last.postId + 1;

      // สร้างออบเจกต์ Postdata ใหม่
      Postdata newPost = Postdata(
        postId: newId,
        image1: _imageBytes1,
        title: _titleController.text,
        content: _contentController.text,
        hashtag: _hashtagController.text,
      );

      // เพิ่มโพสต์ใหม่ลงใน List
      await Postdata.addPost(newPost);

      debugPrint(" โพสต์ใหม่ถูกเพิ่ม: ID ${newPost.postId}");
      debugPrint(" หัวเรื่อง: ${newPost.title}");
      debugPrint(" แฮชแท็ก: ${newPost.hashtag}");

      // บันทึกข้อมูลลง SharedPreferences
      await PostStorage.savePosts();

      // แจ้งเตือนว่าการโพสต์สำเร็จ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('โพสต์ถูกเพิ่มและบันทึกเรียบร้อยแล้ว!')),
      );

      // ล้างฟอร์มหลังโพสต์
      _titleController.clear();
      _contentController.clear();
      _hashtagController.clear();
      setState(() {
        _imageBytes1 = null;
      });

      // สร้างเส้นทาง
    /*   Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultSearchScreen(posts: Postdata.getAllPosts()),
        ),
      ); */
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadExistingPosts();
  }

  // โหลดโพสต์ทั้งหมดจาก SharedPreferences (ถ้ามี)
  Future<void> _loadExistingPosts() async {
    await PostStorage.loadPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  
        backgroundColor: Colors.white,
        title: Text("โพสต์",style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ส่วนเลือกรูปภาพ
             Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Color.fromARGB(217, 217, 217, 217),
                        child: _imageBytes1 == null
                            ? IconButton(
                                icon: Icon(Icons.add_photo_alternate),
                                color: Colors.black,
                                iconSize: 30,
                                 onPressed: () => _pickImage(1),
                              )
                            : Image.memory(
                                _imageBytes1!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
             ),  // พาดหัวเรื่อง
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'เพิ่มพาดหัวเรื่อง',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontSize: 15,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  style: TextStyle(fontSize: 13),
                  validator: (value) => value!.isEmpty ? "กรุณากรอกหัวเรื่อง" : null,
                ),
              ),
              // รายละเอียดโพสต์
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    hintText: 'รายละเอียดโพสต์',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontSize: 15,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  maxLines: 4,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 13),
                  validator: (value) => value!.isEmpty ? "กรุณากรอกรายละเอียดโพสต์" : null,
                ),
              ),
              // ปุ่มเพิ่มแฮชแท็ก
              Row(
                children: [
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _addHashtag,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(217, 217, 217, 217),
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    ),
                    child: Text(
                      '#แฮชแท็ก',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                ],
              ),
              // แฮชแท็กที่น่าสนใจ
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: TextFormField(
                  controller: _hashtagController,
                  decoration: InputDecoration(
                    hintText: 'แฮชแท็กที่น่าสนใจ',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(112, 112, 112, 1),
                      fontSize: 10,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  style: TextStyle(fontSize: 10),
                  validator: (value) => value!.isEmpty ? "กรุณากรอกข้อมูลแฮชแท็ก" : null,
                ),
              ),
              // ปุ่มโพสต์
               Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: SizedBox(
                  width: double.infinity, 
                  child: ElevatedButton(
                    onPressed: _submitPost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(217, 217, 217, 217),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      'โพสต์',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
