import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/model/user_todo_model.dart';
import 'package:todo_flutter_app_node_js_mongodb/providers/auth_provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/providers/user_provider.dart';
import 'package:todo_flutter_app_node_js_mongodb/ui/login/login_page.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/custom_button.dart';
import 'package:todo_flutter_app_node_js_mongodb/utils/helper.dart';

class MyHomePage extends StatefulWidget {
  final dynamic token;
  const MyHomePage({super.key, this.token});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final UserProvider userProvider;
  late final AuthProvider authProvider;

  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loginUserData = JwtDecoder.decode(widget.token);
    userProvider.getTasks(context, userId: authProvider.loginUserData["_id"]);

  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (userProvider.userTodoList.isNotEmpty) {
           return ListView.builder(
               padding: const EdgeInsets.all(16),
               itemCount: userProvider.userTodoList.length,
               itemBuilder: (context, index) {
                 final data = userProvider.userTodoList[index];
                 return Slidable(
                   actionPane: const SlidableScrollActionPane(),
                   actionExtentRatio: 0.1,
                   actions: [
                     IconSlideAction(
                       color: Colors.green,
                       icon: Icons.edit,
                       onTap: (){
                         userProvider.checkIsUpdating(true);
                         showModalBottomSheet(
                           shape: const RoundedRectangleBorder(
                             borderRadius: BorderRadius.only(
                                 topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                           ),
                           context: context,
                           builder: (BuildContext context) {
                             return ModelBottomSheet(data: data);
                           },
                         );
                       },
                     ),

                   ],
                   secondaryActions: [
                     IconSlideAction(
                       color: Colors.red.shade700,
                       icon: Icons.delete,
                       onTap: () {
                         userProvider.deleteTasks(context, taskID: data.id!, userId: data.userId!);
                       },
                     )
                   ],
                   child: GestureDetector(
                     onTap: (){},
                     child: ListTile(
                       onTap: (){},
                       leading: Icon(Icons.task, color: Theme.of(context).colorScheme.inversePrimary),
                       title: Text(data.title ?? "N/A", style: Theme.of(context).textTheme.titleMedium),
                       subtitle: Text(data.description ?? "N/A", style: Theme.of(context).textTheme.titleSmall),
                     ),
                   ),
                 );
               });
          } else {
            return Center(child: Text('No Task Added', style: Theme.of(context).textTheme.titleLarge));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          userProvider.checkIsUpdating(false);
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            context: context,
            builder: (BuildContext context) {
              return const ModelBottomSheet();
            },
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ModelBottomSheet extends StatefulWidget {
  final Todo? data;
  const ModelBottomSheet({Key? key, this.data}) : super(key: key);

  @override
  _ModelBottomSheetState createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late final UserProvider userProvider;
  late final AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    titleController = TextEditingController();
    descriptionController = TextEditingController();

    if(userProvider.isUpdating){
      debugPrint("updatingggggg");
      titleController.text = widget.data!.title ?? "";
      descriptionController.text = widget.data!.description ?? "";
    }
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Add Todo', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: titleController,
                  cursorColor: Colors.black,
                  style: Theme.of(context).textTheme.bodyMedium,
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
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                  cursorColor: Colors.black,
                  style: Theme.of(context).textTheme.bodyMedium,
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
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                debugPrint("id ${authProvider.loginUserData["_id"]}");
                var userId = authProvider.loginUserData["_id"];
                EasyLoading.show(status: userProvider.isUpdating ? 'Updating...' : 'Saving...');
                if(userProvider.isUpdating){
                  await userProvider.updateTask(context,taskId: widget.data!.id!,
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim()).then((_){
                    userProvider.getTasks(context, userId: userId);
                    EasyLoading.dismiss();
                    Navigator.of(context).pop();
                    titleController.clear();
                    descriptionController.clear();
                  });
                }
                else{
                  await userProvider.saveTask(context,
                      userId: userId,
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim()).then((_){
                    userProvider.getTasks(context, userId: userId);
                    EasyLoading.dismiss();
                    Navigator.of(context).pop();
                    titleController.clear();
                    descriptionController.clear();
                  });
                }


              },
              child: CustomButton(
                title: userProvider.isUpdating ? 'Update ': 'Save',
                size: size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
