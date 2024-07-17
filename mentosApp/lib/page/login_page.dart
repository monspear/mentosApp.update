// 로그인 페이지
import 'package:flutter/material.dart';
import 'package:mentos/page/main_home.dart';
import 'package:mentos/page/signup_page.dart';
import 'package:mentos/page/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentos/main.dart';


class login_page extends StatelessWidget {
  //final loginIdController = TextEditingController();  // loginIdController.text : 입력받은 ID 값
  //final loginPwController = TextEditingController();  // loginPwController.text : 입력받은 PW 값
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(30.0, 240.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>
            [
              SizedBox(height: 40.0),
              TextFormField(
                controller: loginIdController,
                decoration: InputDecoration(
                  labelText: 'ID',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: loginPwController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 5.0),
              Container(
                alignment: Alignment(1.0, 0.0),
                padding: EdgeInsets.only(top: 15.0, left: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    '회원가입하기',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                height: 50.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.blueAccent,
                  elevation: 7.0,
                  child: InkWell(
                    onTap: () async {
                      final flaguser = FirebaseFirestore.instance
                          .collection('users')
                          .doc(loginIdController.text); // 로그인 할 때, db에 사용자가 입력한 id가 있는지

                      final snapshot = await flaguser.get(); // 검색 정보 가져오기
                      //debugPrint("snapshot = $snapshot");
                      //debugPrint("snapshot.data()!['userid'] = ${snapshot.data()!['userid']}");
                      final String? db_id = snapshot.data()?['userid']; // db 안의 id
                      final String? db_password = snapshot.data()?['userpassword']; // db 안의 pw
                      //2024-07-17  snapshot.data()!['userid'];의 !를 ?로 대체

                      //debugPrint("id = ${loginIdController.text}");
                      //debugPrint("password = ${loginPwController.text}");
                      //debugPrint("id = $db_id");
                      //debugPrint("password = $db_password");
                      
                      if (db_id == loginIdController.text &&
                          db_password == loginPwController.text) { // db에 저장된 정보 와 입력한 정보가 같은 경우
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("로그인 성공"),
                        ));

                        await Navigator.push(  // 로그인 후 메인페이지로 이동
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );


                      } else { // 사용자가 잘못된 정보로 로그일 할 경우
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("로그인 실패"),
                        ));
                      }
                      
                    },  // 로그인 버튼 눌렀을 때 실행될 함수
                    child: Center(
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
