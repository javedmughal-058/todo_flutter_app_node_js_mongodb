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
      body: FutureBuilder(
          future: authProvider.getLoginInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something Went Wrnong');
            } else {
              return Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('Email ${authProvider.loginUserData["email"]}',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          context: context,
          builder: (BuildContext context) {
            return const ModelBottomSheet();
          },
        ),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet({Key? key}) : super(key: key);

  @override
  _ModelBottomSheetState createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add Todo', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: titleController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.text_fields,
                      color: const Color(0xffACADB9),
                      size: size.width * 0.07,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: descriptionController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: InputBorder.none,
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.description,
                      color: const Color(0xffACADB9),
                      size: size.width * 0.07,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
