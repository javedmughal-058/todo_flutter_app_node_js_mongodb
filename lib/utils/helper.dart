import 'package:flutter/material.dart';

class Helper{

  static goTo(context, page){
    return  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> page));
  }
}