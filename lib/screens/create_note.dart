import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp1/screens/back.dart';

class CreateNote extends StatefulWidget {
  CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateNote> {
  final  _titleController = TextEditingController();
  final  _notesController = TextEditingController();

  var notesList;




  void submithandler() {
    if (_titleController.text.isEmpty && _notesController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
          'Empty Notes!', style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.normal, color: Colors.red))));
    }
    else {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
          'Saved!', style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.normal, color: Colors.green))));
    _titleController.clear();
    _notesController.clear();

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
        'NOTES',
        style: TextStyle(fontWeight: FontWeight.bold,
        color: Colors.white,fontSize: 25),

    ),
        ),
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                TextField(
                  style: const TextStyle(
                    fontSize: 25,fontWeight: FontWeight.bold,color: Colors.grey
                  ),
                  controller: _titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                      hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white),
                    )
                  ),
            SizedBox(height: 20),
                TextField(
                style: const TextStyle(
                fontSize: 25,fontWeight: FontWeight.bold,color: Colors.grey
                ),
                    controller: _notesController,
                decoration: const InputDecoration(
                border:  InputBorder.none,
                hintText: 'Your Note',
                    hintStyle: TextStyle(color: Colors.white),
                ),

                ),


        ]),
          ),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
       Navigator.pop(context,{'title': _titleController.text,
       'note': _notesController.text,},);
      },
      child: const Icon(Icons.save),
    ),
    );


}}