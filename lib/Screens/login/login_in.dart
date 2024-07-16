import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Screens/login/login_navigator.dart';
import 'package:to_do/Screens/login/login_view_model.dart';
import 'package:to_do/Screens/sign_up_screen.dart';
import 'package:to_do/base.dart';
import 'package:to_do/home_layout/home_layout.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseView<LoginViewModel, LoginScreen>
    implements LoginNavigator {
  var userController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        builder: (context, child) {
          return Stack(
            children: [
              Image.asset(
                'assets/images/sign_in_bg.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.wellcomeBack,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 28,
                                      ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            TextFormField(
                              controller: userController,
                              validator: (value) {
                                bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!);

                                if (
                                    //value == null ||
                                    value.isEmpty) {
                                  return 'please enter username';
                                } else if (!emailValid) {
                                  return 'please enter valid username';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  label: const Text(
                                      //AppLocalizations.of(context)!.
                                      "Username"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent))),
                            ),
                            const SizedBox(
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
                                  label: const Text(
                                      //AppLocalizations.of(context)!.
                                      "Password"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.blueAccent))),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                style: const ButtonStyle(
                                    //MaterialStatePropertyAll
                                    backgroundColor: WidgetStatePropertyAll(
                                        Color(0xFF5D9CEC))),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    viewModel.getUserLogin(userController.text,
                                        passwordController.text);
                                    // firebaseFunction.getUserLogin(
                                    //     userController.text,
                                    //     passwordController.text, () {
                                    //
                                    // }, (usermodel) {
                                    //   provider.initUser();
                                    //   Navigator.pushReplacementNamed(
                                    //       context, HomeLayout.routeName,
                                    //       arguments: usermodel);
                                    // });
                                  }
                                },
                                child: const Text(
                                    //AppLocalizations.of(context)!.
                                    'login')),
                            const SizedBox(
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
                                    //AppLocalizations.of(context)!.
                                    'Dont have an account?  ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 14,
                                            color: Colors.black54),
                                  ),
                                  Text(
                                      //AppLocalizations.of(context)!.
                                      'create accounte',
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  goToHome() {
    Navigator.pushReplacementNamed(
      context,
      HomeLayout.routeName,
    );
  }

  @override
  LoginViewModel initViewModel() {
    // TODO: implement initViewModel
    return LoginViewModel();
  }
}
