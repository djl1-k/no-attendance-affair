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
      backgroundColor: Colors.blue,),
      body: StreamBuilder(stream: dbr.child("Rented").onValue, 
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
      
            Map<dynamic, dynamic>? data = snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;
            
            String student = data?['Name'];
            String batch = data?['Batch'];
            if (student != "" && batch != ""){
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("End Rental"),
                        content: Text("Are you sure you want to end the rental?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Reset database and end rental
                              dbr.child('Rented/Name').set('');
                              dbr.child('Rented/Batch').set('');
                              dbr.child('ServoExecuted').set(false);
                              dbr.child('RoomRented').set(0);
                              Navigator.of(context).pop();
                            },
                            child: Text("End rental"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16.0),
                        title: Text("Room 401"),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Student: $student"),
                                    Text("Batch: $batch"),
                                  ],
                                ),
                            Text("Rented from 1:00 - 3:30", style: TextStyle(fontSize: 17),)
                          ],
                                              ),
                        ),
                                  ),
                    ),]
                  ),
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