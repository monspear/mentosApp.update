import 'package:flutter/material.dart';
import 'package:mentos/const/colors.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => IncomeScreenState();
}

class IncomeScreenState extends State<IncomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '신청 내역', // 타이틀
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // 타이틀 가운데 정렬
        elevation: 3, // 앱 바 아래 그림자
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CircleAvatar( // 프로필 이미지 추가
                      backgroundColor: LIGHT_GREY_COLOR,
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      '이름1', // 실제 이름
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: TextButton(
                      onPressed: onSavePressed,
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text(
                        '승인',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  // Profile Image 2
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CircleAvatar(
                      // 프로필 이미지 추가
                      backgroundColor: LIGHT_GREY_COLOR,
                      radius: 30,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Text(
                      '이름2', // 실제 이름
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: TextButton(
                      onPressed: onSavePressed,
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text(
                        '승인',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    // 버튼이 눌렸을 때
  }
}
