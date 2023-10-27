import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_flutter_app_node_js_mongodb/config/api_services.dart';
import 'package:todo_flutter_app_node_js_mongodb/model/user_todo_model.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/toast_alerts.dart';

class UserProvider extends ChangeNotifier {

  ApiService apiService = ApiService();
  final header = {"Content-Type": "application/json"};
  bool isLoading = false;
  var userTodoList = <Todo>[];
  var isUpdating = false;

  void checkIsUpdating(bool value){
    if(value){
      isUpdating = true;
    }
    else{
      isUpdating = false;
    }
    notifyListeners();
  }

  Future<void> saveTask(context, {required String userId,required String title, required String description}) async {
    debugPrint("Calling Save Task");

    try {
      var body = {
        "userId": userId,
        "title": title,
        "description": description
      };
      var response = await apiService.postData(
          apiUrl: 'store', body: jsonEncode(body), header: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"]) {
          debugPrint("Success ${data["status"]}");
          ToastMsg.successToast(msg: data["msg"]);
        } else {
          ToastMsg.errorToast(msg: data["msg"]);
        }
      }
    } catch (e) {
      debugPrint("saveTask $e");
    }
  }

  Future<void> getTasks(context, {required String userId}) async {
    isLoading = true;
    debugPrint("Calling Get Task");

    try {
      var body = {
        "userId": userId,
      };
      var response = await apiService.postData(apiUrl: 'getUserTodo', body: jsonEncode(body), header: header);
      if (response.statusCode == 200) {
        isLoading = false;
        var data = jsonDecode(response.body);
        if (data["status"]) {
          userTodoList.clear();
          debugPrint("Task Available ${data["status"]}");
          userTodoList = userTodoModelFromJson(response.body).todoData ?? [];
        }
        else {
          ToastMsg.errorToast(msg: data["msg"]);
        }
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      debugPrint("getTasks $e");
    }
  }

  Future<void> deleteTasks(context, {required String taskID, required String userId}) async {
    isLoading = true;
    debugPrint("Deleting Task");

    try {
      var body = {
        "taskId": taskID,
      };
      var response = await apiService.postData(
          apiUrl: 'deleteTodo', body: jsonEncode(body), header: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"]) {
          debugPrint("Task Delete ${data["status"]}");
          ToastMsg.errorToast(msg: data["msg"]);
          getTasks(context, userId: userId);
        }
        else {
          ToastMsg.errorToast(msg: data["msg"]);
        }
      }
    } catch (e) {
      isLoading = false;
      debugPrint("deleteTasks $e");
    }
  }

  Future<void> updateTask(context, {required String taskId,required String title, required String description}) async {
    debugPrint("Calling Update Task");

    try {
      var body = {
        "id": taskId,
        "title": title,
        "description": description
      };
      var response = await apiService.postData(
          apiUrl: 'updateTodo', body: jsonEncode(body), header: header);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"]) {
          debugPrint("Success ${data["status"]}");
          ToastMsg.successToast(msg: data["msg"]);
        } else {
          ToastMsg.errorToast(msg: data["msg"]);
        }
      }
    } catch (e) {
      debugPrint("updateTask $e");
    }
  }

}