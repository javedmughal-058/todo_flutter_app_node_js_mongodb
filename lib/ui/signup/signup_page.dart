import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/providers/auth_provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/ui/login/login_page.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.inversePrimary,
                  // Colors.black
                ]
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, size.height* 0.08, 20, 0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign Page", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 5,),
                  Text("Register Yourself", style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        SizedBox(height: size.height * 0.15),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color:  Theme.of(context).colorScheme.inversePrimary,
                                    blurRadius: 0.2,
                                    spreadRadius: 0.1,
                                    offset:  const Offset(0, 0)
                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Theme.of(context).colorScheme.inversePrimary, width: 0.5))
                                ),
                                child: TextFormField(
                                  controller: authProvider.emailController,
                                  decoration: InputDecoration(
                                      hintText: "Email",
                                      errorText: authProvider.isValueNotAvailable ? "Enter Email" : null ,
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  controller: authProvider.passwordController,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      errorText: authProvider.isValueNotAvailable ? "Enter Password" : null,
                                      hintStyle:  const TextStyle(color: Colors.grey),
                                      border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            authProvider.checkValueAvailable();
                            if(!authProvider.isValueNotAvailable){
                              EasyLoading.show(status: 'Please wait...!');
                              authProvider.registerUser(context).then((value) =>  EasyLoading.dismiss());
                            }

                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.inversePrimary,
                                    ]
                                )
                            ),
                            child: const Center(
                              child: Text("SignUp", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Helper.goTo(context, const LoginPage());
                          },
                          child: Text("Already have an account?",
                            style:  TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.black
                            ),),
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
