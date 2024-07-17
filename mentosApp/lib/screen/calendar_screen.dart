import 'package:flutter/material.dart';
import 'package:mentos/component/main_calendar.dart';
import 'package:mentos/component/schedule_card.dart';
import 'package:mentos/component/today.dart';
import 'package:mentos/component/schedule_button.dart';
import 'package:mentos/const/colors.dart';

class HomeScreen extends StatefulWidget {
  final int number;
  const HomeScreen({
    required this.number,
    Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: BLUE_COLOR,

        onPressed: (){
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleButtonSheet(),

            isScrollControlled: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,

              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            Today(
              selectedDate: selectedDate,
              count: 0,
            ),
            SizedBox(height: 8.0),
            ScheduleCard(
              startTime: 12,
              endTime: 14,
              content: '일정 내용',
            )
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate){

    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}