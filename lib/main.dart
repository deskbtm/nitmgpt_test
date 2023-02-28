import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'notification_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<Permission, PermissionStatus> statuses = await [
    Permission.notification,
  ].request();

  if (statuses.values.every((v) => v.isGranted)) {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nitmgpt Test',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'nitmgpt test notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textEditingController = TextEditingController();
  final _textEditingController1 = TextEditingController();

  @override
  void initState() {
    LocalNotification.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Send noitifaction',
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('title'),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'content',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  minLines: 6,
                  controller: _textEditingController1,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await LocalNotification.showNotification(
              channelName: 'nitmgpt test',
              title: _textEditingController.text,
              subTitle: _textEditingController1.text,
            );
          },
          tooltip: 'Increment',
          child: const Icon(Icons.send),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
