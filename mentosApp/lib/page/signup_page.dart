// 회원가입 페이지
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentos/page/login_page.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController firstNameController = TextEditingController();  // firstNameController.text : 입력받은 성 값
  TextEditingController lastNameController = TextEditingController();   // lastNameController.text : 입력받은 이름 값
  TextEditingController signupIdController = TextEditingController();   // signupIdController.text : 입력받은 id 값
  TextEditingController signupPwController = TextEditingController();   // signupPwController.text : 입력받은 pw 값
  TextEditingController checkPwController = TextEditingController();    // checkPwController.text : 입력받은 pw재확인 값
  TextEditingController emailController = TextEditingController();      // emailController.text : 입력받은 이메일 값
  TextEditingController birthdayController = TextEditingController();   // birthdayController.text : 입력받은 생년월일 값

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: '성',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: '이름',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 8.0),
            TextField(
              controller: signupIdController,
              decoration: InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 8.0),
            TextField(
              controller: signupPwController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 8.0),
            TextField(
              controller: checkPwController,
              decoration: InputDecoration(
                labelText: '비밀번호 확인',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 8.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(height: 8.0),
            TextField(
              controller: birthdayController,
              decoration: InputDecoration(
                labelText: '생년월일',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () async {
                // 입력한 것에 대한 에러들을 잡고 await를  불러들여야 함.

                var flag = 0; // 만약 에러가 생기면 0이 아니게 됨.

                List<String> checkInfo = [
                  firstNameController.text,
                  lastNameController.text,
                  signupIdController.text,
                  signupPwController.text,
                  checkPwController.text,
                  emailController.text,
                  birthdayController.text
                ];

                for (int i = 0; i < checkInfo[5].length; i++) {
                  if (checkInfo[5][i] == "@") {
                    flag = 0;
                    print("이메일체크성공");
                    break;
                  } else {
                    flag = 4;
                  }
                }
                for (int i = 0; i < checkInfo.length; i++) {  // 입력한  내용이 비어있는지 확인
                 
                  if (checkInfo[i] == "") {
                    flag = 1;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("입력한 내용중 하나 이상이 비어있습니다."),
                    ));
                  }
                }

                if (checkInfo[3] != checkInfo[4]) { // 비밀번호와 비밀번호확인이 같은지
                  
                  flag = 2;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("비밀번호가 같지 않습니다."),
                    ));
                }

                if (checkInfo[6].length != 8) {// 생년월일을 8자리로 입력한게 맞는지
                  
                  flag = 3;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("생년월일을 8자리로 입력해주세요."),
                    ));
                }

                final flaguser = FirebaseFirestore.instance.collection('users').doc(checkInfo[2]); // db에 사용자가 입력한 id가 있는지
                final snapshot = await flaguser.get(); // 검색해서 받아오기
                //debugPrint(snapshot.data()!['useremail']); // useremail 데이터가져오기
                
                if(snapshot.exists){ // 회원가입중 이미 존재하는 id 인 경우
                  flag = 5;
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("이미 존재하는 id 입니다."),
                    ));
                }
                
                if (flag == 0) { // 에러사항이 없는 경우
                  try {
                    //https://www.youtube.com/watch?v=ErP_xomHKTw
                    
                    final docUser = FirebaseFirestore.instance
                        .collection('users') 
                        .doc(checkInfo[2]); // firebase database에 'users'라는 컬렉션에 사용자가 입력한 아이디로 작은 문서를 만듬
                        

                    var year = birthdayController.text.toString().substring(0,4); // 생일년도 저장
                    var month = birthdayController.text.toString().substring(4,6); // 생일 월 저장
                    var day = birthdayController.text.toString().substring(6,8); // 생일 일 저장
                    //debugPrint(year+month+day);

                    final userInfoJson = User( // 위에 언급한 작은 문서에 저장할 사용자의 개인정보를 다음 형식으로 지정
                      firstname: firstNameController.text,
                      lastname: lastNameController.text,
                      userid: signupIdController.text,
                      userpassword: signupPwController.text,
                      useremail: emailController.text,
                      userbirthday: DateTime(int.parse(year), int.parse(month), int.parse(day)), // DateTime으로 변환하여 저장
                    );

                    await docUser.set(userInfoJson.toJson()); // 사용자의 개인정보를 문서로 만들어 저장


                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("회원가입에 성공하셨습니다."),
                    ));
                    debugPrint("회원가입 성공");

                    await Navigator.push( // 로그인 페이지로 이동
                        context,
                        MaterialPageRoute(builder: (context) => login_page()),
                      );
                
                  } catch (e) {
                    // 파이어베이스어스에서 에러발생
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.toString()),
                    ));
                  } 
                }
                // 회원가입 버튼이 눌렸을 때 실행할 코드
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor, // 버튼의 배경색
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 버튼의 모서리를 둥글게 설정
                ),
                minimumSize: Size(double.infinity, 50), // 버튼의 최소 크기를 설정
              ),
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
      )
    );
  }
}


class User{
  final String firstname;
  final String lastname;
  final String userid;
  final String userpassword;
  final String useremail;
  final DateTime userbirthday;
  String haveto;
  User({
    required this.firstname,
    required this.lastname,
    required this.userid,
    required this.userpassword,
    required this.useremail,
    required this.userbirthday,
    this.haveto = ""
  });

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "userid": userid,
    "userpassword": userpassword,
    "useremail": useremail,
    "userbirthday": userbirthday,
    "haveto" :haveto,
  };

  static User fromJson(Map<String,dynamic> json) =>User(
    firstname: json['firstname'], 
    lastname: json['lastname'], 
    userid: json['userid'], 
    userpassword: json['userpassword'], 
    useremail: json['useremail'], 
    userbirthday: (json['userbirthday'] as Timestamp).toDate(),
    );

@override

String toString() => 'User<$firstname:$lastname>';
}