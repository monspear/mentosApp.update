// 스터디 생성 페이지
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mentos/const/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentos/main.dart';

class PlusPost extends StatefulWidget {
  @override
  _PlusPostState createState() => _PlusPostState();
}

class _PlusPostState extends State<PlusPost> {
  
  TextEditingController contentsController =
      TextEditingController(); // contentsController.text : 입력받은 모집내용 값
  TextEditingController hashtagController =
      TextEditingController(); // hashtagController.text : 입력받은 해시태그 값
  TextEditingController peopleController =
      TextEditingController(); // peopleController.text : 입력받은 모집인원 수 값
  TextEditingController startDateController =
      TextEditingController(); // startDateController.text : 입력받은 모집기간(시작일) 값
  TextEditingController endDateController =
      TextEditingController(); // endDateController.text : 입력받은 모집기간(종료일) 값

  // 게시물 생성 메서드
  void createPost() {
    // 게시물 데이터 생성
    String title = titleController.text;
    String contents = contentsController.text;
    String hashtag = hashtagController.text;
    String people = peopleController.text;
    String startDate = startDateController.text;
    String endDate = endDateController.text;

    // main_home 페이지로 돌아가면서 게시물 데이터 전달
    Navigator.pop(context, {
      'title': title,
      'contents': contents,
      'hashtag': hashtag,
      'people': people,
      'startDate': startDate,
      'endDate': endDate,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('스터디 생성'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Positioned(
                  child: Text(
                    '제목',
                    style: TextStyle(
                      color: BLUE_COLOR,
                    ),
                  ),
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: '제목을 입력해주세요',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25.0),
                Positioned(
                  child: Text(
                    '모집 내용',
                    style: TextStyle(
                      color: BLUE_COLOR,
                    ),
                  ),
                ),
                Container(
                  height: 200.0,
                  child: TextField(
                    maxLines: 7,
                    controller: contentsController,
                    decoration: InputDecoration(
                      hintText: '내용을 입력해주세요',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Positioned(
                  child: Text(
                    '해시태그',
                    style: TextStyle(
                      color: BLUE_COLOR,
                    ),
                  ),
                ),
                TextField(
                  controller: hashtagController,
                  decoration: InputDecoration(
                    hintText: '#해시태그',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25.0),
                Positioned(
                  child: Text(
                    '모집 인원',
                    style: TextStyle(
                      color: BLUE_COLOR,
                    ),
                  ),
                ),
                TextField(
                  controller: peopleController,
                  decoration: InputDecoration(
                    suffix: Text('명'),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25.0),
                Positioned(
                  child: Text(
                    '모집 기간',
                    style: TextStyle(
                      color: BLUE_COLOR,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: startDateController,
                        decoration: InputDecoration(
                          hintText: '시작일 입력',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: TextFormField(
                        controller: endDateController,
                        decoration: InputDecoration(
                          hintText: '종료일 입력',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35.0),
                ElevatedButton(
                  onPressed: () async {
                    
                    //createPost,
                    //await createPost;
                    List<String> checkInfo = [
                      titleController.text,
                      contentsController.text,
                      hashtagController.text,
                      peopleController.text,
                      startDateController.text,
                      endDateController.text,
                      loginIdController.text,
                    ];
                    var flag = 0; // checkInfo의 내용이 모두 입력 되었늕지
                    var compare_start = 0;
                    var compare_end = 0;
                    
                     for(int i = 0; i < checkInfo[2].length; i++){
                      if(checkInfo[2][i] == "#"){
                        flag = 0;
                        break;
                      } else{
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("#태그를 달아야합니다."),
                      ));
                        flag = 3;
                        break;
                      }
                    }
                    
                    for (int i = 0; i < checkInfo.length; i++) {
                      // 입력한  내용이 비어있는지 확인
                      if (checkInfo[i] == "") {
                        flag = 1;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("입력한 내용중 하나 이상이 비어있습니다."),
                        ));
                      }
                    }

                    if (checkInfo[4].length != 8 || checkInfo[5].length != 8) {
                      flag = 2;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("날짜를 8자리로 입력해주세요."),
                      ));
                    }

                    if(checkInfo[4].length == 8 && checkInfo[5].length == 8){
                      compare_start = int.parse(
                        checkInfo[4].toString().substring(0, 8)); // 시작일
                      compare_end = int.parse(
                        checkInfo[5].toString().substring(0, 8)); // 종료일
                        if(compare_start >= compare_end){
                          flag = 4;
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("시작일은 종료일보다 이전이어야 합니다."),
                      ));
                        }
                    }
                    print(flag);
                   if(flag == 0){
                    
                    final Info = FirebaseFirestore.instance
                        .collection('info')
                        .doc(checkInfo[6]+checkInfo[0]); // 
                       
                    //final db_id = snapshot.data()!['userid'];
                    //final db_password = snapshot.data()!['userpassword'];
                    var year_s =
                        startDateController.text.toString().substring(0, 4);
                    var month_s =
                        startDateController.text.toString().substring(4, 6);
                    var day_s =
                        startDateController.text.toString().substring(6, 8);

                    var year_e =
                        endDateController.text.toString().substring(0, 4);
                    var month_e =
                        endDateController.text.toString().substring(4, 6);
                    var day_e =
                        endDateController.text.toString().substring(6, 8);

                    final postInfoJson = PostInfo(
                      //
                      title_info: titleController.text,
                      contents_info: contentsController.text,
                      hashtag_info: hashtagController.text,
                      people_info: peopleController.text,
                      startDate_info: DateTime(int.parse(year_s),
                          int.parse(month_s), int.parse(day_s)),
                      endDate_info: DateTime(int.parse(year_e),
                          int.parse(month_e), int.parse(day_e)),
                      userid: loginIdController.text,
                    );
                    /*
                    print("title : ${titleController.text}");
                    print("contents : ${contentsController.text}");
                    print("hashtag : ${hashtagController.text}");
                    print("people : ${peopleController.text}");
                    print("start : ${DateTime(int.parse(year_s),
                          int.parse(month_s), int.parse(day_s))}");
                    print("end : ${DateTime(int.parse(year_e),
                          int.parse(month_e), int.parse(day_e))}");
                    print("userid : ${loginIdController.text}");
                    */
                    await Info
                        .set(postInfoJson.toJson()); // 사용자의 개인정보를 문서로 만들어 저장
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("게시물이 정상적으로 등록되었습니다."),
                    ));

                    Navigator.pop(context);
                   }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor, // 버튼의 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // 버튼의 모서리를 둥글게 설정
                    ),
                    minimumSize: Size(double.infinity, 50), // 버튼의 최소 크기를 설정
                  ),
                  child: Text('만들기'),
                ),
              ],
            ),
          ),
        ));
  }
}

class PostInfo {
  final String title_info;
  final String contents_info;
  final String hashtag_info;
  final String people_info;
  final DateTime startDate_info;
  final DateTime endDate_info;
  final String userid;
  PostInfo({
    required this.title_info,
    required this.contents_info,
    required this.hashtag_info,
    required this.people_info,
    required this.startDate_info,
    required this.endDate_info,
    required this.userid,
  });

  Map<String, dynamic> toJson() => {
        "title_info": title_info,
        "contents_info": contents_info,
        "hashtag_info": hashtag_info,
        "people_info": people_info,
        "startDate_info": startDate_info,
        "endDate_info": endDate_info,
        "userid": userid,
      };
}
