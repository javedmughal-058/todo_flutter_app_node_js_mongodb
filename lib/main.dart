import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter_app_node_js_mongodb/providers/auth_provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/ui/home.dart';
import 'package:todo_flutter_app_node_js_mongodb/ui/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(token: pref.getString("token"))));
}

class MyApp extends StatelessWidget {
  final dynamic token;
  const MyApp({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: token == null
          ? const LoginPage()
          : (JwtDecoder.isExpired(token) == false)
              ? const MyHomePage()
              : const LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}
