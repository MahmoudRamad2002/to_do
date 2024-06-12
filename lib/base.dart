import 'package:flutter/material.dart';

abstract class BaseNavigator {
  showLoading(String message);

  hideDialog();

  showMessage(String message);
}

class BaseViewModel<NAV extends BaseNavigator> extends ChangeNotifier {
  NAV? connector = null;
}

abstract class BaseView<VM extends BaseViewModel, ST extends StatefulWidget>
    extends State<ST> implements BaseNavigator {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
    viewModel.connector = this;
  }

  @override
  hideDialog() {
    Navigator.pop(context);
  }

  @override
  showLoading(message) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  showMessage(message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              child: Text('OK!'))
        ],
        content: Text(message),
      ),
    );
  }
}
