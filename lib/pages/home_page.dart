import 'package:flutter/material.dart';
import 'package:usemangedemo/models/user_model.dart';
import 'package:usemangedemo/pages/detalis_page.dart';
import 'package:usemangedemo/services/prefs_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<User> items = [];

  _callDetailsPage()async {
    var result = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
      return DetalisPage();
    }));
    if(result){
      _lodUserList();
    }
  }
  _lodUserList()async{
    var users = await PrefsService.loadUserList();
    setState(() {
      items = users;
    });
  }

  @override
  void initState() {
    super.initState();
    _lodUserList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
        title: Text("User List"),
      ),

      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, int index){
          return _itemOfUsers(items[index]);
        },
      ),

      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
        onPressed: (){
            _callDetailsPage();
          },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _itemOfUsers(User user){
    return Container(
      margin: EdgeInsets.only(top: 8),
      color: Colors.grey.shade300,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(user.name!, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
          Text(user.id!.toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        ],
      ) ,
    );
  }

}
