import 'package:mentos/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:mentos/component/edit_text_field.dart';

class Edit extends StatelessWidget {
  final int number;

  const Edit({
    required this.number,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    return SafeArea(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 2 + bottomInset,
        color: WHITE_COLOR,
        child: Padding(
          padding: EdgeInsets.only(
              left: 8, right: 8, top: 8, bottom: bottomInset),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: EditTextField(
                      label: '제목',
                      isTime: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: EditTextField(
                  label: '내용',
                  isTime: false,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSavePressed,
                  style: ElevatedButton.styleFrom(
                    //primary: BLUE_COLOR,
                  ),
                  child: Text('등록하기'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSavePressed() {

  }
}