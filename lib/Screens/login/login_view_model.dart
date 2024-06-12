import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do/Screens/login/login_navigator.dart';
import 'package:to_do/base.dart';

class LoginViewModel extends BaseViewModel<LoginNavigator> {
  void getUserLogin(String emailAddress, String password) async {
    try {
      connector!.showLoading("");
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      connector!.hideDialog();
      connector!.goToHome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // UserNotFoundit(e.message);
        //print('No user found for that email.');
        connector!.showMessage(e.message ?? "");
      } else if (e.code == 'wrong-password') {
        // UserNotFoundit(e.message);
        connector!.showMessage("");
      }
    }
  }
}
