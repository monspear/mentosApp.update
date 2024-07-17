import 'package:mentos/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:mentos/screen/income_screen.dart';
import 'package:mentos/page/main_study.dart';

class MainScreen extends StatelessWidget {
  final int number;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  MainScreen({
    required this.number,
    Key? key,
  }) : super(key: key);

  Future<bool> _onWillPop(BuildContext context) async {
    // 뒤로 가기 버튼을 눌렀을 때 실행되는 함수
    _scaffoldKey.currentState?.openDrawer(); // 창이 뜨기 전의 상태로 돌아갑니다.
    return false; // false를 반환하여 기본 뒤로가기 동작을 막습니다.
  }

  static const List<String> postTitles = [
    '공지사항 입니다!! 꼭 읽어주세요',
    '안녕하세요!!',
    'C언어 책 괜찮은거 있나요??',
    '포인터 관련해서 도와주실분 ㅠㅠ',
    '방금 가입했어요 잘 부탁드립니다!!',
  ];

  void navigateToNextPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainStudy(number: number)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: BLUE_COLOR,
            title: Text(
              'C언어 스터디',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemCount: postTitles.length,
            itemBuilder: (context, index) {
              final postTitle = postTitles[index];
              return Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            postTitle,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: WHITE_COLOR,
                ),
                accountName: Text('이름'),
                accountEmail: Text('email@naver.com'),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '멤버',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ButtonTheme(
                      padding: EdgeInsets.zero,
                      minWidth: 0,
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isDismissible: true,
                            builder: (_) => IncomeScreen(),
                            isScrollControlled: true,
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              '들어온 신청',
                              style: TextStyle(
                                color: DARK_GREY_COLOR,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: BLUE_COLOR,
                ),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('이름'),
                      TextButton(
                        onPressed: () {
                          // 버튼이 클릭되었을 때
                          print('Button clicked');
                        },
                        child: Text(
                          '내보내기',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: DARK_GREY_COLOR,
                ),
                title: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('이름2'),
                      TextButton(
                        onPressed: () {
                          // 버튼이 클릭되었을 때
                          print('Button clicked');
                        },
                        child: Text(
                          '내보내기',
                          style: TextStyle(
                            color: Colors.red,
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
