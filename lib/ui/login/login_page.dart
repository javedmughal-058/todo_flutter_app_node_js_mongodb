import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/providers/auth_provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/ui/signup/signup_page.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/custom_button.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.inversePrimary,
          // Colors.black
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, size.height * 0.08, 20, 0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height * 0.15),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    blurRadius: 0.2,
                                    spreadRadius: 0.1,
                                    offset: const Offset(0, 0))
                              ]),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            width: 0.5))),
                                child: TextFormField(
                                  controller: authProvider.emailController,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      errorText:
                                          authProvider.isValueNotAvailable
                                              ? "Email Required"
                                              : null,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                            width: 0.5))),
                                child: TextFormField(
                                  controller: authProvider.passwordController,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      errorText:
                                          authProvider.isValueNotAvailable
                                              ? "Password Required"
                                              : null,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            authProvider.checkValueAvailable();
                            if (!authProvider.isValueNotAvailable) {
                              EasyLoading.show(status: 'Please wait...!');
                              authProvider
                                  .login(context)
                                  .then((value) => EasyLoading.dismiss());
                            }
                          },
                          child: CustomButton(title: 'Login', size: size),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Helper.goTo(context, const SignUpPage());
                          },
                          child: Text(
                            "Create new account",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
