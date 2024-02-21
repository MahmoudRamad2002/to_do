import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/Screens/update_screen.dart';
import 'package:to_do/firebise/firebaseFunction.dart';
import 'package:to_do/models/Task_module.dart';
import 'package:to_do/shared/style/app_color.dart';

class TaskWidget extends StatelessWidget {
  TaskModel taskModel;

  TaskWidget(this.taskModel);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            //  autoClose: true,
            onPressed: (context) {
              firebaseFunction.deletTask(taskModel.id);
            },
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
            backgroundColor: Colors.red,
          ),
          SlidableAction(
            // autoClose: true,
            onPressed: (context) {
              Navigator.pushNamed(context, UpdateScreen.routeName,
                  arguments: taskModel);
            },
            icon: Icons.edit,
            label: AppLocalizations.of(context)!.edit,
            backgroundColor: Theme.of(context).primaryColor,
          )
        ],
      ),
      child: SizedBox(
        height: 90,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                child: VerticalDivider(
                  thickness: 3,
                  width: 30,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title.toString(),
                      style: taskModel.stutes
                          ? Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: appColor.GreenColor)
                          : Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      taskModel.describition ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              const Spacer(),
              taskModel.stutes
                  ? Text(
                      AppLocalizations.of(context)!.done,
                      style: TextStyle(color: appColor.GreenColor),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          right: 20, left: 20, bottom: 5, top: 5),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.done, color: Colors.white, size: 30),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
