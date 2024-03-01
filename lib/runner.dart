import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/addTodo.dart';
import 'package:todoapp/widget/todoList.dart';
import 'package:url_launcher/url_launcher.dart';

class runner extends StatefulWidget {
  const runner({super.key});

  @override
  State<runner> createState() => _runnerState();
}

class _runnerState extends State<runner> {
  
  List<String> todoList = [];
  
  void changeTxt({required String todoTxt}){
    if(todoList.contains(todoTxt)){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Task already exists'),
          content: Text('Task already exists'),
          actions: [InkWell(
            onTap: () {Navigator.pop(context);},
            child: Text('Close'))],
        );
      });
      return;
    }
    setState(() {
      todoList.insert(0, todoTxt);
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async{
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', todoList);
  }

  void loadData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList('todoList') ?? []).toList();
    setState(() {});
  }

  void addView(){
    showModalBottomSheet(context: context, builder: (context){
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container( padding: EdgeInsets.all(20), height: 200, child: addTodo(changeTxt: changeTxt,),),
      );
    });
  }

  @override
  void initState(){
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blueGrey[900],
        child: Icon(Icons.add, color: Colors.white),
        onPressed: addView
      ),
      drawer: Drawer(child: Column(children: [
        Container(
          color: Colors.blueGrey[900],
          height: 200,
          width: double.infinity,
          child: Center(child: Text('TODO App', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        ),
        ListTile(
          onTap: (){
            launchUrl(Uri.parse('https://github.com/JLaurenz'));
          },
          leading: Icon(Icons.question_mark),
          title: Text('About Me', style: TextStyle(fontWeight: FontWeight.bold),)),
        ListTile(
          onTap: (){
            launchUrl(Uri.parse('mailto: gmail@gmail.com'));
          },
          leading: Icon(Icons.contact_mail),
          title: Text('Contact Me', style: TextStyle(fontWeight: FontWeight.bold),)),
      ],)),
      appBar: AppBar( centerTitle: true, title: const Text('Todo App'),
      ),
      body: todoListView(todoList: todoList, updateLocalData: updateLocalData)
    );
  }
}