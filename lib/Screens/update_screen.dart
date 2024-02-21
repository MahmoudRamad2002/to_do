import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/firebise/firebaseFunction.dart';
import 'package:to_do/models/Task_module.dart';
import 'package:to_do/shared/style/my_them_data.dart';

class UpdateScreen extends StatefulWidget {
  static const String routeName = 'update';

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var titleController = TextEditingController();

  var describitionController = TextEditingController();

  DateTime selectedDateTime = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    titleController.text = task.title!;
    describitionController.text = task.describition!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myThemeData.lightColor,
        title: Text(AppLocalizations.of(context)!.todo,
            style: myThemeData.ligthTheme.textTheme.titleSmall),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.updatetask,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
                label: Text(AppLocalizations.of(context)!.edittasktitle),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor))),
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
                label: Text(AppLocalizations.of(context)!.edittaskdescription),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor))),
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
              task.title = titleController.text;
              task.describition = describitionController.text;
              firebaseFunction.updateTask(task.id, task);
              Navigator.pop(context);
            },
            child: Text(
              AppLocalizations.of(context)!.saved,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFF5D9CEC))),
          )
        ],
      ),
    );
  }

  void chooseTaskData(BuildContext context) async {
    DateTime? choosenDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: selectedDateTime,
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (choosenDateTime != null) {
      selectedDateTime = DateUtils.dateOnly(choosenDateTime);
      setState(() {});
    }
  }
}
