import 'package:flutter/material.dart';
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
      body: Center(
        child:
            Text('TO-DO App', style: Theme.of(context).textTheme.titleMedium),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
