import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class tasker extends StatefulWidget {
  const tasker({super.key});

  @override
  State<tasker> createState() => _taskerState();
}

class _taskerState extends State<tasker> {
  // List for List Tile
  List thislist = [];

  //Text Flields Controllers
  TextEditingController addvaluecontroller = TextEditingController();
  TextEditingController updatevaluecontroller = TextEditingController();

  // Adding Value to List Function
  addvalue() {
    setState(
      () {
        if (addvaluecontroller.text != "") {
          thislist.insert(0, addvaluecontroller.text);
          addvaluecontroller.clear();
        } else {
          showDialog(
            context: context,
            builder: (builder) {
              return const AlertDialog(
                title: Text("Warning"),
                content: Text(
                    "Please insert task, Blank field is not Supposed to Add!"),
              );
            },
          );
        }
      },
    );
  }

  // Delete Value Function From List
  deleteval({indexofvalue}) {
    setState(
      () {
        thislist.removeAt(indexofvalue);
      },
    );
  }

  // Edit Value Function
  updateval({indexvalue}) {
    setState(
      () {
        updatevaluecontroller.text = thislist[indexvalue];
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Update Value"),
              content: TextField(
                controller: updatevaluecontroller,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      thislist[indexvalue] = updatevaluecontroller.text;
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Update Value"),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Welcome To Tasker",
            style: TextStyle(
              color: Colors.deepPurple[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: 300,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 7),
                      child: TextField(
                        controller: addvaluecontroller,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent),
                    onPressed: () {
                      addvalue();
                    },
                    child: Text(
                      "Add Task",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: thislist.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 4),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.deepPurple[50],
                        title: Text(
                          thislist[index],
                          maxLines: 5, //customize your number of lines
                        ),

                        // Action Buttons

                        trailing: Wrap(
                          children: [
                            IconButton(
                              //
                              // Edit Icon Button

                              onPressed: () {
                                updateval(indexvalue: index);
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              //
                              // Delete Icon Button

                              onPressed: () {
                                setState(
                                  () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Warning"),
                                          content: ElevatedButton(
                                            onPressed: () {
                                              deleteval(indexofvalue: index);
                                              Navigator.pop(context);
                                            },
                                            child: Text("Sure Delet?"),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
