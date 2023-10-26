// To parse this JSON data, do
//
//     final userTodoModel = userTodoModelFromJson(jsonString);

import 'dart:convert';

UserTodoModel userTodoModelFromJson(String str) => UserTodoModel.fromJson(json.decode(str));

String userTodoModelToJson(UserTodoModel data) => json.encode(data.toJson());

class UserTodoModel {
  List<Todo>? todoData;

  UserTodoModel({
    this.todoData,
  });

  factory UserTodoModel.fromJson(Map<String, dynamic> json) => UserTodoModel(
    todoData: List<Todo>.from(json["data"].map((x) => Todo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(todoData!.map((x) => x.toJson())),
  };
}

class Todo {
  String? id;
  String? userId;
  String? title;
  String? description;
  int? v;

  Todo({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.v,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    description: json["description"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "title": title,
    "description": description,
    "__v": v,
  };
}
