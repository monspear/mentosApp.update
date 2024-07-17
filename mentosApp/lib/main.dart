import 'package:flutter/material.dart';
import 'package:mentos/page/login_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';

TextEditingController loginIdController = TextEditingController(); // 사용자의 id
TextEditingController loginPwController = TextEditingController(); // 사용자의 비밀번호
TextEditingController titleController =TextEditingController(); // titleController.text : 입력받은 제목 값
String musthave = ""; // 나의 스터디를 임시저장
// ignore: non_constant_identifier_names
String a_date = ""; // 나의 스터디의 날짜를 임시저장
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
        home: login_page()
    ),
  );
}