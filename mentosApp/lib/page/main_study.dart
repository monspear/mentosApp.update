import 'package:flutter/material.dart';
import 'package:mentos/main.dart';
import 'package:mentos/navigation_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Post1 {
  final String title;
  final String author;

  Post1({
    required this.title,
    required this.author,
  });
}

class MainStudy extends StatelessWidget {
  final int number;

  const MainStudy({
    required this.number,
    Key? key,
  }) : super(key: key);

  void navigateToPostDetail(BuildContext context, Post1 post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RootScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    List<Post1> posts = [ 
      Post1(                     // 이전에 저장했던 제일 첫번째 게시물의 정보(제목과 종료일)을 넣음
        title: musthave,
        author: a_date,
      ),
      Post1(
        title: '프론트엔드(React) 스터디',
        author: '3/8',
      ),
      Post1(
        title: '정보처리기사 자격증 공부',
        author: '4/5',
      ),
    ];

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('나의 스터디'),
        ),
        body:  
        ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            Post1 post = posts[index];
            return InkWell(
              onTap: () => navigateToPostDetail(context, post),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.person, size: 15),
                        SizedBox(width: 4),
                        Text(
                          post.author,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
