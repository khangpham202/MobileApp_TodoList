import 'package:flutter/material.dart';
import 'models/task_model.dart';
import 'widgets/app_bar_container.dart';
import 'widgets/modal_input_field.dart';
import 'screens/today_screen.dart';
import 'screens/tomorrow_screen.dart';
import 'screens/upcoming_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter By Tan Khang Pham',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildItemCategory(Color color, Function() onTap, String title) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: 16,
            ),
            decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'RobotoMono',
              ),
            ),
          ),
        ],
      ),
    );
  }

  final List<Task> taskList = [
    Task(
      name: 'gghjjgh',
      createdTime: DateTime.now(),
      deadlineTime: "26-12-2002",
      description: "9.5",
    ),
    Task(
      name: '6666666',
      createdTime: DateTime.now(),
      deadlineTime: "17-03-2023",
      description: "9.5",
    ),
  ];

  void addNewTask({
    required String name,
    required DateTime createdTime,
    required String deadlineTime,
    required String description,
  }) {
    final newTask = Task(
      name: name,
      createdTime: createdTime,
      deadlineTime: deadlineTime,
      description: description,
    );

    setState(
      () {
        taskList.add(newTask);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBarContainer(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 170,
                height: 130,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/avt.png'),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle)),
            Text(
              "What's up, Lionel!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(239, 225, 225, 220),
              ),
            ),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              child: Card(
                color: Colors.green,
                child: Center(
                  child: Text(
                    'Personal Task Management',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ), //Text
                ), //Center
              ), //
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              child: _buildItemCategory(Color(0xffFE9C5E), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TomorrowScreen()));
              }, 'Out of date'),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              child: _buildItemCategory(Color(0xffFE9C5E), () {
                final List<Task> todayTasks = taskList;
                // .where(
                //   // ignore: unrelated_type_equality_checks
                //   (element) => element.deadlineTime == DateTime.now(),
                // )
                // .toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodayScreen(
                      todayTask: todayTasks,
                    ),
                  ),
                );
              }, 'Today'),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              child: _buildItemCategory(Color(0xffFE9C5E), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TomorrowScreen()));
              }, 'Tomorrow'),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              child: _buildItemCategory(Color(0xffFE9C5E), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpComingScreen()));
              }, 'Up Coming'),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return ModaLInputField(
                        addTask: addNewTask,
                      );
                    },
                  );
                },
                label: Row(
                  children: const <Widget>[
                    Text("Add task"),
                    Icon(Icons.add),
                  ],
                ),
                backgroundColor: Color.fromARGB(209, 218, 46, 46),
                extendedTextStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
