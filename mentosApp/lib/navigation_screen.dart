import 'package:flutter/material.dart';
import 'package:mentos/screen/home_screen.dart';
import 'package:mentos/screen/edit_screen.dart';
import 'package:mentos/screen/calendar_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);
  @override
  State createState() => _RootScreenState();
}

class _RootScreenState extends State with TickerProviderStateMixin {
  TabController? controller;
  int number = 2;


  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this); // 컨트롤러 초기화
//컨트롤러 속성이 변경될 때 마다 실행할 함수
    controller!.addListener(tabListener);
  }

  tabListener() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller, // 컨트롤러 등록
        children: rendChildren(),
      ),
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> rendChildren(){
    return [
      MainScreen(number: number),
      HomeScreen(number: number),
      Edit(number: number),
    ];
  }

  BottomNavigationBar renderBottomNavigation() {
    return BottomNavigationBar(
      currentIndex: controller!.index,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: SizedBox.shrink(), // 빈 아이콘
          label: '메인',
        ),
        BottomNavigationBarItem(
          icon: SizedBox.shrink(), // 빈 아이콘
          label: '일정',
        ),
        BottomNavigationBarItem(
          icon: SizedBox.shrink(), // 빈 아이콘
          label: '게시글 작성',
        ),
      ],
    );
  }
}