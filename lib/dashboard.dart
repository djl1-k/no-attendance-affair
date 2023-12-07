// ignore_for_file: prefer_const_constructors

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbr = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("Rented Rooms"),
      backgroundColor: Colors.blue[200],),
      body: StreamBuilder(stream: dbr.child("Rented").onValue, 
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
      
            Map<dynamic, dynamic>? data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
            
            String student = data?['Name'];
            String batch = data?['Batch'];
            if (student != "" && batch != ""){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text("Room 401"),
                      subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Student: $student"),
                        Text("Batch: $batch"),
                      ],
                    ),
                                ),
                  ),]
                ),
              );           
          }
          else {
              return Container(); // Handle the case where student or batch is empty
            }
        }
        else {
          return Container();
        }
      }
    ),
    );
  }
}