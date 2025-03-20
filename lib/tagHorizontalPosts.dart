import 'package:flutter/material.dart';
import 'package:project_weebworld/data/postdata.dart';
import 'package:project_weebworld/detail_post_screen.dart';

class TagHorizontalPosts extends StatelessWidget {
  final String hashtagTitle;      
  final List<Postdata> allPosts; 

  const TagHorizontalPosts({
    Key? key,
    required this.hashtagTitle,
    required this.allPosts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // กรองเฉพาะโพสต์ที่มี hashtag 
    final filteredPosts = allPosts.where((post) {
      return post.hashtag.contains(hashtagTitle);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ส่วนหัว Hashtag
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.5),
                    width: 1.0,
                  ),
                ),
                child: Center(
                  child: Text(
                    "#",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                hashtagTitle.replaceAll("#", ""), 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // ถ้าไม่มีโพสต์
        if (filteredPosts.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "ไม่มีโพสต์สำหรับ $hashtagTitle",
              style: TextStyle(fontSize: 16),
            ),
          )
        else
          // ถ้ามีโพสต์
          SizedBox(
            height: 100, // กำหนดความสูงของโซนแสดงรูป
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filteredPosts.length,
              separatorBuilder: (context, index) => SizedBox(width: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemBuilder: (context, index) {
                final post = filteredPosts[index];
                return GestureDetector(
                  onTap: () {
                    // กดแล้วไปหน้ารายละเอียดโพสต์
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostDetailScreen(post: post),
                      ),
                    );
                  },
                  child: Container(
                    width: 100, 
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: post.image1 != null
                          ? Image.memory(
                              post.image1!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/default.png",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
