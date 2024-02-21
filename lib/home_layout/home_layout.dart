import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/login_in.dart';
import 'package:to_do/Screens/settinScreen.dart';
import 'package:to_do/Screens/taskScreen.dart';
import 'package:to_do/Screens/widgets/show_add_task_button_sheet.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/shared/style/my_them_data.dart';

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
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () {
                provider.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Icon(Icons.logout))
        ],
        backgroundColor: myThemeData.lightColor,
        title: Text('TODO APP ${provider.myuser?.name}',
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
        // clipBehavior: Clip.antiAlias,
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
              const BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "")
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
