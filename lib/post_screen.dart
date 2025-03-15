import 'package:flutter/material.dart';
import 'package:project_weebworld/home_screen.dart';
import 'package:project_weebworld/navbarComponent.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: Color.fromARGB(255, 160, 160, 160),
                  ),
                );
              },
            ),
            centerTitle: true,
            title: Text("โพสต์", style: TextStyle(fontSize: 13)),
          ),
        ),

        body: Form(
          child: Column(
            children: [
              Container(margin: EdgeInsets.only(left: 15),child: Row(
                children: [
                  SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child:Container(
                      color: Color.fromARGB(217, 217, 217, 217),
                      child: IconButton(
                    icon: Icon(Icons.add_photo_alternate),
                    color: Color.fromARGB(255, 0, 0, 0),
                    iconSize: 30,
                    onPressed: () {},
                  ),), 
                  )
                  ,SizedBox(width:10),
                   ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child:Container(
                      color: Color.fromARGB(217, 217, 217, 217),
                      child: IconButton(
                    icon: Icon(Icons.add_photo_alternate),
                    color: Color.fromARGB(255, 0, 0, 0),
                    iconSize: 30,
                    onPressed: () {},
                  ),), 
                  )
                ],
              ),)
            ,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'เพิ่มพาดหัวเรื่อง',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1),
                          fontSize: 15,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'รายละเอียดโพสต์',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1),
                          fontSize: 15,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                      maxLines: 10, // กำหนดให้พิมพ์ได้ไม่จำกัดบรรทัด
                      minLines: null, // จำนวนบรรทัดเริ่มต้น
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 1),
              Row(
                children: [
                  Container(margin: EdgeInsets.only(left: 15)),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(217, 217, 217, 217),

                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      '#แฮชแท็ก',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),

              /*          Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(217, 217, 217, 217),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 20,
                    width: 80,
                    child: Text(
                      "#แฮชแท็ก",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ), */
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'แฮชแท็กที่น่าสนใจ',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(112, 112, 112, 1),
                          fontSize: 10,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                      ),
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 1),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Center(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // จัดเรียงให้เหมาะสม
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(217, 217, 217, 217),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            'โพสต์',
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
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
