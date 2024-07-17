import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentos/component/plus_post.dart';
import 'package:mentos/const/colors.dart';

import 'package:mentos/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentos/page/signup_page.dart';

class Post {
  String title;
  String contents;
  String hashtag;
  String people;
  String startDate; // 시작일과 종료일을 시간타입으로
  String endDate;
  //String startDate;
  //String endDate;
  bool isLiked;

  Post({
    required this.title,
    required this.contents,
    required this.hashtag,
    required this.people,
    required this.startDate,
    required this.endDate,
    this.isLiked = false,
  });
}

class MainHome extends StatefulWidget {
  final int number;

  const MainHome({
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  List<Post> posts = [];
  void openCreatePostPage() async {
    await Navigator.push( // 파란색 바탕의 +버튼을 눌렀을 때
      context,
      MaterialPageRoute(builder: (context) => PlusPost()),
    );

    final flaguser = FirebaseFirestore.instance.collection('info'); // db에 저장된 게시물들을

    final snapshot = await flaguser.get(); // 가져오기

    //final flaguser = FirebaseFirestore.instance.collection('users').doc(checkInfo[2]);
    //snapshot.data()!['useremail']

    //print("snashot.size = ${snapshot.size}");
    //print("data = ${snapshot.docs[0].data()}");
    //print("data = ${snapshot.docs[0].data()['test']}");
    //print("data = ${snapshot.docs[0].id}");

    Timestamp start = snapshot.docs[0].data()['startDate_info']; // +버튼에서 시작일을 입력한 뒤
    DateTime start2 = start.toDate();
    String start3 = DateFormat('MM/dd/yyyy, hh:mm a').format(start2); // 시작일을 보기쉬운 형식으로 바꿈.

    Timestamp end = snapshot.docs[0].data()['endDate_info']; // 종료일을 입력한 뒤
    DateTime end2 = start.toDate();
    String end3 = DateFormat('MM/dd/yyyy, hh:mm a').format(start2); // 종료일을 보기 쉬운 형식으로 바꿈.

    //print(Timestamp.fromMillisecondsSinceEpoch(snapshot.docs[0].data()['startDate_info']));
    print("Date : ${snapshot.docs[0].data()['startDate_info']}");

    for (int i = 0; i < snapshot.size; i++) {
      setState(() {
        Post result = Post( // 게시물을 올렸을 때, 메인 페이지에 나타나게 할 양식
          title: snapshot.docs[i].data()['title_info'],
          contents: snapshot.docs[i].data()['contents_info'],
          hashtag: snapshot.docs[i].data()['hashtag_info'],
          people: snapshot.docs[i].data()['people_info'],
          startDate: start3,
          endDate: end3,
        );
        posts.add(result); // 추가하기
      });
    }

    /*
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlusPost()),
    );

    if (result != null && result is Map) {
      setState(() {
        Post post = Post(
          title: result['title'],
          contents: result['contents'],
          hashtag: result['hashtag'],
          people: result['people'],
          startDate: result['startDate'],
          endDate: result['endDate'],
        );
        posts.add(post);
      });
    }
    */
  }

  void toggleLike(int index) {
    setState(() {
      posts[index].isLiked = !posts[index].isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(posts[index].title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(posts[index].contents),
                              Text(posts[index].hashtag),
                              SizedBox(height: 10),
                              Text('인원 : ${posts[index].people}명'),
                              Text(
                                  '모집기간 : ${posts[index].startDate} ~ ${posts[index].endDate}'),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          posts[index].isLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: posts[index].isLiked ? BLUE_COLOR : null,
                        ),
                        onPressed: () => toggleLike(index),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: BLUE_COLOR,
                        ),
                        onPressed: () async { // 메인페이지에 만들어진 게시물의 + 를 눌렀을 때.
                          final haveto = FirebaseFirestore.instance
                              .collection('users')
                              .doc(loginIdController.text);
                          final snapshot = await haveto.get(); // 지금 사용하는 사용자의 정보를 가져옴.

                          final flaguser =
                              FirebaseFirestore.instance.collection('info');
                          final snapshot2 = await flaguser.get(); // 게시물의 정보도 가져옴.

                          //print(snapshot.data()!['userbirthday']);
                          Timestamp t_birth = snapshot.data()!['userbirthday'];
                          DateTime u_birthday = t_birth.toDate();  // 사용자의 정보를 업데이트할 때 날짜 형식을 다시 세팅

                          //print("u_birthday = $u_birthday");

                          final userinfo = User( // 사용자의 정보에서 빈칸인 나의 스터디에 게시물의 정보를 넣기 위함.
                              firstname: snapshot.data()!['firstname'],
                              lastname: snapshot.data()!['lastname'],
                              userid: snapshot.data()!['userid'],
                              userpassword: snapshot.data()!['userpassword'],
                              useremail: snapshot.data()!['useremail'],
                              userbirthday: u_birthday,
                              haveto: snapshot.data()!['haveto'] +
                                  snapshot2.docs[0].data()['userid'] +
                                  snapshot2.docs[0].data()['title_info']);

                        musthave = snapshot2.docs[0].data()['title_info']; // 제일 첫번째 게시물의 제목을 musthave에 저장.
                        a_date = DateFormat('MM/dd/yyyy, hh:mm a').format(u_birthday); // 제일 첫번째 게시물의 종료일도 a_date에 저장
                         
                          await haveto.set(userinfo.toJson());// 사용자의 개인정보 업데이트(나의 스터디가 추가된 사항.)
                        }, // '+' 버튼을 눌렀을 때의 동작 구현
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openCreatePostPage,
        child: Icon(Icons.add),
      ),
    );
  }
}
