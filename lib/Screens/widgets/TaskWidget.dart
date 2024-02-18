import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: true,
            onPressed: (context) {},
            icon: Icons.delete,
            label: 'Delete',
            backgroundColor: Colors.red,
          ),
          SlidableAction(
            // autoClose: true,
            onPressed: (context) {},
            icon: Icons.edit,
            label: 'Edit',
            backgroundColor: Theme.of(context).primaryColor,
          )
        ],
      ),
      child: SizedBox(
        height: 90,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Container(
                height: 70,
                child: VerticalDivider(
                  thickness: 3,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tast title',
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Description Task',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding:
                    EdgeInsets.only(right: 20, left: 20, bottom: 5, top: 5),
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
