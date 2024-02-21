import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do/firebise/firebaseFunction.dart';
import 'package:to_do/models/user-module.dart';

class MyProvider extends ChangeNotifier {
  UserModel? myuser;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  void initUser() async {
    firebaseUser = FirebaseAuth.instance.currentUser;

    myuser = await firebaseFunction.readUser(firebaseUser!.uid);
    notifyListeners();
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }
}
