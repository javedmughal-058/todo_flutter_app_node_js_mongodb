import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:todo_flutter_app_node_js_mongodb/config/api_services.dart';
import 'package:todo_flutter_app_node_js_mongodb/ui/home.dart';
import 'package:todo_flutter_app_node_js_mongodb/ui/login/login_page.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/helper.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/toast_alerts.dart';

class AuthProvider extends ChangeNotifier {
  bool isValueNotAvailable = false;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ApiService apiService = ApiService();
  final header = {"Content-Type": "application/json"};

  void checkValueAvailable() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      isValueNotAvailable = true;
      notifyListeners();
    } else {
      isValueNotAvailable = false;
      notifyListeners();
    }
  }

  Future<void> registerUser(context) async {
    debugPrint("Calling Register");
    debugPrint(emailController.text.toString());
    debugPrint(passwordController.text.toString());

    try {
      var body = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim()
      };
      var response = await apiService.postData(
          apiUrl: 'registration', body: jsonEncode(body), header: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        emailController.clear();
        passwordController.clear();

        debugPrint("Success ${data["status"]}");
        ToastMsg.successToast(msg: data["msg"]);
        Helper.goTo(context, const LoginPage());
      }
    } catch (e) {
      debugPrint("registerUser $e");
    }
  }

  Future<void> login(context) async {
    debugPrint("Calling login");
    debugPrint(emailController.text.toString());
    debugPrint(passwordController.text.toString());

    try {
      var body = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim()
      };
      var response = await apiService.postData(
          apiUrl: 'login', body: jsonEncode(body), header: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"]) {
          emailController.clear();
          passwordController.clear();

          debugPrint("Success ${data["status"]}");
          ToastMsg.successToast(msg: data["msg"]);
          Helper.goTo(context, const MyHomePage());
        } else {
          ToastMsg.errorToast(msg: data["msg"]);
        }
      }
    } catch (e) {
      debugPrint("login $e");
    }
  }
}