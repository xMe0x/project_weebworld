import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_weebworld/TagHorizontalPosts.dart';
import 'package:project_weebworld/data/postdata.dart';
import 'package:project_weebworld/data/PostStorage.dart';


class TagSearchScreen extends StatefulWidget {
  const TagSearchScreen({super.key});

  @override
  State<TagSearchScreen> createState() => _TagSearchScreenState();
}

class _TagSearchScreenState extends State<TagSearchScreen> {
  List<Postdata> posts = [];

  final List<String> bannerPaths = [
    "images/banner/banner1.png",
    "images/banner/banner2.png",
    "images/banner/banner3.png",
  ];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await PostStorage.loadPosts();
    setState(() {
      posts = Postdata.getAllPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                viewportFraction: 0.8,
              ),
              items: bannerPaths.map((imagePath) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            // เรียก Widget ที่เราเขียนไว้สำหรับแต่ละ Hashtag
            TagHorizontalPosts(
              hashtagTitle: "#อนิเมะ",
              allPosts: posts,
            ),
            SizedBox(height: 20),

            TagHorizontalPosts(
              hashtagTitle: "#มังงะ",
              allPosts: posts,
            ),
            SizedBox(height: 20),

            TagHorizontalPosts(
              hashtagTitle: "#นิยาย",
              allPosts: posts,
            ),

            // หากมี Hashtag อื่น ๆ อีกก็เพิ่มได้
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
