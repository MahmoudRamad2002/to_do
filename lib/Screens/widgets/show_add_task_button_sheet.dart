import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/firebise/firebaseFunction.dart';
import 'package:to_do/models/Task_module.dart';

class showAddTaskButtonSheet extends StatefulWidget {
  @override
  State<showAddTaskButtonSheet> createState() => _showAddTaskButtonSheetState();
}

class _showAddTaskButtonSheetState extends State<showAddTaskButtonSheet> {
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var describitionController = TextEditingController();
  DateTime selectedDateTime = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.addtask,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter task title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.title),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                SizedBox(
                  height: 26,
                ),
                TextFormField(
                  controller: describitionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Task Description";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      label:
                          Text(AppLocalizations.of(context)!.taskdescription),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor))),
                ),
                SizedBox(
                  height: 26,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.selecttime,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                InkWell(
                  onTap: () {
                    chooseTaskData(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      selectedDateTime.toString().substring(0, 10),
                      //style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // WidgetsBinding.instance.addPostFrameCallback;
                      TaskModel task = TaskModel(
                          title: titleController.text,
                          date: selectedDateTime.millisecondsSinceEpoch,
                          describition: describitionController.text,
                          userId: FirebaseAuth.instance.currentUser?.uid,
                          stutes: true);
                      firebaseFunction.addTask(task).then((value) {
                        Navigator.pop(context);
                      });
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF5D9CEC))),
                  child: Text(
                    AppLocalizations.of(context)!.addtask,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseTaskData(BuildContext context) async {
    DateTime? choosenDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (choosenDateTime != null) {
      selectedDateTime = DateUtils.dateOnly(choosenDateTime);
      setState(() {});
    }
  }
}
