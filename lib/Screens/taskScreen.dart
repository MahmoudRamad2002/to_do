import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Screens/widgets/TaskWidget.dart';

class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Theme.of(context).primaryColor,
          selectedTextColor: Colors.white,
          height: 100,
          onDateChange: (Newdate) {
            // New date selected
            setState(() {
              date = Newdate;
            });
          },
        ),
        SizedBox(
          height: 18,
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemBuilder: (context, index) {
              return TaskWidget();
            },
            itemCount: 5,
          ),
        )
      ],
    );
  }
}
