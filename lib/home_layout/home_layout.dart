import 'package:flutter/material.dart';
import 'package:to_do/Screens/settinScreen.dart';
import 'package:to_do/Screens/taskScreen.dart';
import 'package:to_do/Screens/widgets/show_add_task_button_sheet.dart';
import 'package:to_do/shared/style/mt_them_data.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  static const String routeName = 'home';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myThemeData.lightColor,
        title: Text('TODO APP',
            style: myThemeData.ligthTheme.textTheme.titleSmall),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            showAddTaskSheet();
          },
          shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 3)),
          child: Icon(Icons.add)),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconSize: 30,
            currentIndex: index,
            onTap: (value) {
              index = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
            ],
          ),
        ),
      ),
      body: tabs[index],
      //
      //
      //
      //
    );
  }

  List<Widget> tabs = [TaskScreen(), SettingScreen()];

  void showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return showAddTaskButtonSheet();
      },
    );
  }
}
