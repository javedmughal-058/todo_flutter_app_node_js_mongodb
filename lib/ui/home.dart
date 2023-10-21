import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/providers/auth_provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/ui/login/login_page.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/helper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo App'),
        actions: [
          IconButton(
              onPressed: () => Helper.goTo(context, const LoginPage()),
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Email ${authProvider.loginUserData["email"]}',
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
