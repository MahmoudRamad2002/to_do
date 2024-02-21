import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/Screens/widgets/TaskWidget.dart';
import 'package:to_do/firebise/firebaseFunction.dart';

import '../models/Task_module.dart';

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
          dateTextStyle: TextStyle(fontSize: 10),
          dayTextStyle: TextStyle(fontSize: 10),
          monthTextStyle: TextStyle(fontSize: 10),
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
        StreamBuilder<QuerySnapshot<TaskModel>>(
          stream: firebaseFunction.getTaskfromFirestore(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Column(
                children: [
                  Text(AppLocalizations.of(context)!.somethingwentwrong),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(AppLocalizations.of(context)!.tryagain)),
                ],
              );
            }
            var tasksList =
                snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
            if (tasksList.isEmpty) {
              return Center(child: Text(AppLocalizations.of(context)!.notasks));
            }
            return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return TaskWidget(tasksList[index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: tasksList.length),
            );
          },
        )
        // Expanded(
        // child: ListView.separated(
        //   separatorBuilder: (context, index) {
        //     return SizedBox(
        //       height: 10,
        //     );
        //   },
        //   itemBuilder: (context, index) {
        //     return TaskWidget();
        //   },
        //   itemCount: 5,
        // ),
        // )
      ],
    );
  }
}
