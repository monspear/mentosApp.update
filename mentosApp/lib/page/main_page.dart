import 'package:flutter/material.dart';
import 'package:mentos/page/main_home.dart';
import 'package:mentos/page/main_heart.dart';
import 'package:mentos/page/main_study.dart';
import 'package:mentos/page/login_page.dart';

import 'package:mentos/main.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  
  @override
  State createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TabController? controller;
  int number = 2;
  List<Post> likedPosts = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller!.addListener(tabListener);
  }

  tabListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller,
        children: rendChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> rendChildren() {
    return [
      MainHome(number: number),
      MainHeart(number: number, likedPosts: likedPosts, toggleLike: toggleLike),
      MainStudy(number: number),
    ];
  }

  void toggleLike(Post post) {
    setState(() {
      if (likedPosts.contains(post)) {
        likedPosts.remove(post);
      } else {
        likedPosts.add(post);
      }
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      showSelectedLabels: true,
      onTap: (int index) {
        setState(() {
          if (index == 0){
            
            controller!.animateTo(index);
          }
          else if (index == 3) {
            _showLogoutConfirmationDialog(); // 로그아웃 아이콘 클릭 시 로그아웃 확인 대화상자 표시
          } else {
            controller!.animateTo(index);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 28,
            color: Colors.blueGrey,
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            size: 28,
            color: Colors.blueGrey,
          ),
          label: '찜 목록',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            size: 28,
            color: Colors.blueGrey,
          ),
          label: '나의 스터디',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.logout,
            size: 28,
            color: Colors.blueGrey,
          ),
          label: '로그아웃',
        ),
      ],
    );
  }

  void _showLogoutConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('로그아웃 하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login_page()),
                  
                );
              },
              child: Text('예'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 대화상자 닫기
              },
              child: Text('아니오'),
            ),
          ],
        );
      },
    );
  }
}
