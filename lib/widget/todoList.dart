// ignore_for_file: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';


class todoListView extends StatefulWidget {
  List<String> todoList;
  void Function() updateLocalData;
  todoListView({super.key, required this.todoList, required this.updateLocalData});
  
  @override
  State<todoListView> createState() => _todoListViewState();
}

class _todoListViewState extends State<todoListView> {
  void onItemClick(int index){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(onPressed: (){
          setState(() {
            widget.todoList.removeAt(index);
          });
          widget.updateLocalData();
          Navigator.pop(context);
        }, child: const Text('Mark as done')));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty) ? const Center(child: Text('No Tasks available!')) : ListView.builder(
        itemCount: widget.todoList.length,
        itemBuilder: (BuildContext context, int index){
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.startToEnd,
          // secondaryBackground: Container(color: Colors.red, child: Row(mainAxisAlignment: MainAxisAlignment.end,  children: [Icon(Icons.delete)])),
          background: Container(color: Colors.green, child: const Row(children: [Icon(Icons.check)])),
          onDismissed: (direction){
            setState(() {
              widget.todoList.removeAt(index);
            });
            widget.updateLocalData();
          },
          child: ListTile(
            onTap: () {
              onItemClick(index);
            },
            title: Text(widget.todoList[index]),
            // leading: Icon(Icons.arrow_back),
            // trailing: Icon(Icons.arrow_back_ios_new),
          ),
        );
      });
  }
}