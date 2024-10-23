import 'package:flutter/material.dart';
import 'package:usemangedemo/models/user_model.dart';
import 'package:usemangedemo/services/prefs_service.dart';

class DetalisPage extends StatefulWidget {
  const DetalisPage({super.key});

  @override
  State<DetalisPage> createState() => _DetalisPageState();
}

class _DetalisPageState extends State<DetalisPage> {

  TextEditingController idController = TextEditingController();
  TextEditingController nameCintroller = TextEditingController();
   _saveNewUser() async{
    String id = idController.text.toString().trim();
    String name = nameCintroller.text.toString().trim();
  User user = new User(id: int.parse(id), name: name);
  //save to shared preference
     var users = await PrefsService.loadUserList();
     users.add(user);

     await PrefsService.storeUserList(users);

     Navigator.of(context).pop(true);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(controller: idController, decoration: InputDecoration(hintText: 'User Id')

              ),
              SizedBox(height: 10,),


              TextField(controller: nameCintroller, decoration: InputDecoration(hintText: 'User name'),
              ),

              SizedBox(height: 10,),
              MaterialButton(
                color: Colors.blue,
                  onPressed: (){
                  _saveNewUser();
                  },
              child: Text("Save"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
