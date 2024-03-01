// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

class addTodo extends StatefulWidget {

  void Function({required String todoTxt}) changeTxt;
  addTodo({super.key, required this.changeTxt});

  @override
  State<addTodo> createState() => _addTodoState();
}

class _addTodoState extends State<addTodo> {
  TextEditingController newTodo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Add todo'), 
        TextField(
          onSubmitted: (value) {
            if(newTodo.text.isNotEmpty){
              widget.changeTxt(todoTxt: newTodo.text);
            }
            newTodo.text = ''; 
          },
          autofocus: true, 
          controller: newTodo, 
          decoration: const InputDecoration(contentPadding: EdgeInsets.all(10), 
          labelText: 'TODO Title')),
        ElevatedButton(onPressed: (){
          if(newTodo.text.isNotEmpty){
            widget.changeTxt(todoTxt: newTodo.text);
          }
          newTodo.text = ''; 
          }, 
          child: const Text('Add Button'))
      ],
    );
  }
}