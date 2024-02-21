import 'package:flutter/material.dart';
import 'package:to_do/Screens/login_in.dart';
import 'package:to_do/firebise/firebaseFunction.dart';
import 'package:to_do/home_layout/home_layout.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = 'singUp';
  var emailController = TextEditingController();
  var ageController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter first name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: Text('enter first name'),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(12))),
                ),
                SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);

                    if (value == null || value.isEmpty) {
                      return 'please enter Email';
                    }
                    // else if (emailValid) {
                    //   return 'please enter valid username';
                    // }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: Text('enter  Email Address'),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(12))),
                ),
                SizedBox(
                  height: 14,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter Age';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      label: Text('enter Age'),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
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
                    }
                    // else if (value.length < 6) {
                    //   return ' please enter at least 6 char';
                    // }
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
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF5D9CEC))),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        firebaseFunction.creatAuthantionEmail(
                            nameController.text,
                            emailController.text,
                            ageController.text,
                            passwordController.text, () {
                          Navigator.pushReplacementNamed(
                              context, HomeLayout.routeName);
                        });
                      }
                    },
                    child: Text('Sing Up')),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'I have an account?  ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14, color: Colors.black54),
                      ),
                      Text('Back Login',
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
        ],
      ),
    );
  }
}
