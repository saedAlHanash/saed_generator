import 'package:flutter/material.dart';
import 'package:saed_generator/utile.dart';

import '../const_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Row(
        children: [
          Expanded(
              child: Container(
            height: 200.0,
            color: Colors.amber,
          )),
          Expanded(
              child: Container(
            height: 200.0,
            color: Colors.amber,
          )),
        ],
      ),
    );
  }
}

class FullService extends StatefulWidget {
  const FullService({super.key});

  @override
  State<FullService> createState() => _FullServiceState();
}

class _FullServiceState extends State<FullService> {
  final rootFolderController = TextEditingController();
  final nameServiceController = TextEditingController();
  final apiNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Full service'),
      ),
      body: Column(
        children: [
          Text('rootFolder'),
          SizedBox(height: 5.0),
          TextFormField(controller: rootFolderController),
          Text('nameService'),
          SizedBox(height: 5.0),
          TextFormField(controller: nameServiceController),
          Text('apiName'),
          SizedBox(height: 5.0),
          TextFormField(controller: apiNameController),
          SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              rootFolder = rootFolderController.text;
              nameService = nameServiceController.text;
              apiName = apiNameController.text;
              createFoldersAndFiles();
            },
            child: Text('Create Folders and Files'),
          ),
        ],
      ),
    );
  }
}
