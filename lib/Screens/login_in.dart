import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/sign_up_screen.dart';
import 'package:to_do/firebise/firebaseFunction.dart';
import 'package:to_do/home_layout/home_layout.dart';
import 'package:to_do/provider/my_provider.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = 'login';
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/sign_in_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          SizedBox(
            height: 14,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Wellcome Back!',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 28,
                            ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  TextFormField(
                    controller: userController,
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);

                      if (value == null || value.isEmpty) {
                        return 'please enter username';
                      }
                      // else if (emailValid) {
                      //    return 'please enter valid username';
                      // }
                      return null;
                    },
                    decoration: InputDecoration(
                        label: Text('enter email'),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter password";
                      } else if (value.length < 6) {
                        return ' please enter at least 6 char';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blueAccent))),
                  ),
                  /*TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      RegExp regex =
                      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      if (value==null||value!.isEmpty) {
                        return 'Please enter password';
                      } else {
                        if (!regex.hasMatch(value)) {
                          return 'Enter valid password';
                        } else {
                          return null;
                        }
                      }
                    },
                    decoration: InputDecoration(
                        label: Text('enter password'),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(12))),
                  ) ,*/
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Color(0xFF5D9CEC))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          firebaseFunction.getUserLogin(
                              userController.text, passwordController.text, () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => AlertDialog(
                                title: Text('Error'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK!'))
                                ],
                                content: Text('Wrong in email or password'),
                              ),
                            );
                          }, (usermodel) {
                            provider.initUser();
                            Navigator.pushReplacementNamed(
                                context, HomeLayout.routeName,
                                arguments: usermodel);
                          });
                        }
                      },
                      child: Text('login')),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SignUpScreen.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Dont have an account?  ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14, color: Colors.black54),
                        ),
                        Text('create accounte',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 18))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
