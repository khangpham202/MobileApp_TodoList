import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'models/task_model.dart';
import 'screens/out_of_date_screen.dart';
import 'widgets/app_bar_container.dart';
import 'widgets/modal_input_field.dart';
import 'screens/today_screen.dart';
import 'screens/tomorrow_screen.dart';

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
  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
  }

  Widget _buildItemCategory(
      Color color, Function() onTap, String title, int quantity) {
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
              "$title - $quantity",
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

  List<Task> taskList = [
    Task(
      name: 'het han',
      createdTime: DateTime.now(),
      deadlineTime: "2023-03-16",
      description: "9.5",
    ),
    Task(
      name: 'mai',
      createdTime: DateTime.now(),
      deadlineTime: "2023-03-21",
      description: "9.5",
    ),
    Task(
      name: 'nay',
      createdTime: DateTime.now(),
      deadlineTime: "2023-03-20",
      description: "9.5",
    ),
    Task(
      name: 'nay1',
      createdTime: DateTime.now(),
      deadlineTime: "2023-03-20",
      description: "9.9",
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
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String now = dateFormat.format(DateTime.now());
    List<Task> outOfDateTasks =
        taskList.where((e) => e.deadlineTime.compareTo(now) < 0).toList();
    List<Task> todayTasks =
        taskList.where((e) => e.deadlineTime.compareTo(now) == 0).toList();
    List<Task> tomorrowTasks =
        taskList.where((e) => e.deadlineTime.compareTo(now) > 0).toList();
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
                      fontSize: 35,
                    ),
                  ), //Text
                ), //Center
              ), //
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: _buildItemCategory(Color.fromARGB(255, 0, 0, 0), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OutOfDateScreen(outOfDateTask: outOfDateTasks)));
              }, 'Out of date', outOfDateTasks.length),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: _buildItemCategory(Color(0xffFE9C5E), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TodayScreen(
                      todayTask: todayTasks,
                    ),
                  ),
                );
              }, 'Today', todayTasks.length),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: _buildItemCategory(Color(0xffFE9C5E), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TomorrowScreen(
                              tomorrowTask: tomorrowTasks,
                            )));
              }, 'Up Coming', tomorrowTasks.length),
            ),
            SizedBox(
              height: 15,
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
