import 'package:flutter/material.dart';

import 'models/Todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Todo It',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black), 
          bodyText2:  TextStyle(color: Colors.black), 
        )
      ),
      home: MyHomePage(title: 'Just Todo It'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Todo> items = [
    Todo(title: "First task", isDone: false), 
    Todo(title: "Second task", isDone: false), 
    Todo(title: "Third task", isDone: false), 
    Todo(title: "Fourth task", isDone: true), 
  ];

  bool _isSelected = false;

  TextEditingController _newTaskController = new TextEditingController();

  addNewTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.52, 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text("Add new task", 
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 15, 
                    fontWeight: FontWeight.bold, 
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: TextFormField(
                  controller: _newTaskController,
                  autofocus: true,
                  onFieldSubmitted: (value) {
                    setState(() {
                      items.add(Todo(
                        title: value, 
                        isDone: false, 
                      ));
                    });
                    Navigator.of(context).pop();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        width: 1, 
                      )
                    )
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FlatButton(
                    color: Colors.blue, 
                    onPressed: () {
                      setState(() {
                        items.add(Todo(title: _newTaskController.text.toString(), isDone: false));
                        _newTaskController.text = "";
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Add Task", 
                      style: TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.bold, 
                        fontSize: 16, 
                      ),
                    ),
                  ),
                )
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title, 
          style: TextStyle(
            color: Colors.black, 
          )
        ),
        leading: IconButton(
          icon: Icon(Icons.add), 
          color: Colors.black,
          onPressed: () {
            addNewTask(context);
          },
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () {
                setState(() {
                  _isSelected = true; 
                });
              },
              onTap: () {
                setState(() {
                  _isSelected = false; 
                });
              },
              child: Card(
                color: _isSelected ? Colors.redAccent : Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(items[index].title, 
                          softWrap: true,
                          maxLines: 10,
                          style: TextStyle(
                            color: _isSelected ? Colors.white : Colors.black, 
                            fontSize: 15, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      _isSelected == true ? IconButton(
                        enableFeedback: true,
                        icon: Icon(Icons.close),
                        iconSize: 20, 
                        onPressed: () {
                          setState(() {
                            items.removeAt(index);
                            _isSelected = false;
                          });
                        },
                      ) : Container(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            );
          } 
        ),
      ),
    );
  }
}
