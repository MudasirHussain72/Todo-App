import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/task_tile_widget.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late final ValueNotifier<List<TaskModel>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<Map<String, dynamic>> _firestoreData = []; // Store Firestore data
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    // // Defer the execution of fetchAndSetTasksCount until after the build phase
    // Future.delayed(Duration.zero, () {
    //   Provider.of<HomeController>(context, listen: false)
    //       .fetchAndSetTasksCount();
    // });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Calendar'),
        ),
        body:
            Consumer<HomeController>(builder: (context, homeController, child) {
          _firestoreData =
              homeController.tasksList.map((goal) => goal.toJson()).toList();
          if (!mounted) {
            return SizedBox.shrink();
          } else {
            return Column(
              children: [
                TableCalendar<TaskModel>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: _selectedEvents.value.isEmpty
                      ? Center(
                          child: Text(
                            'Select a date to list tasks',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 18,
                                    color: AppColors.secondaryTextColor),
                          ),
                        )
                      : ValueListenableBuilder<List<TaskModel>>(
                          valueListenable: _selectedEvents,
                          builder: (context, taskList, _) {
                            return ListView.builder(
                              itemCount: taskList.length,
                              itemBuilder: (context, index) {
                                return StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('User')
                                      .doc(SessionController().user.uid)
                                      .collection('goals')
                                      .doc(taskList[index].goalId)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var data = snapshot.data!.data()
                                          as Map<String, dynamic>?;
                                      if (data != null &&
                                          snapshot.data!.exists) {
                                        String goalTitle =
                                            data['goalTitle'] ?? '';
                                        List<Map<String, dynamic>>
                                            streamTaskList =
                                            List<Map<String, dynamic>>.from(
                                                data['taskList'] ?? []);

                                        // Calculate completed tasks count
                                        int completedTasksCount = streamTaskList
                                            .where((task) =>
                                                task['isCompleted'] == true)
                                            .length;

                                        return TaskTileWidget(
                                          taskDetail: taskList[index],
                                          goalName: goalTitle,
                                          goalTasksCompletedCount:
                                              completedTasksCount,
                                          goalTasksTotalCount:
                                              streamTaskList.length,
                                        );
                                      } else {
                                        // Handle case when data is null or document doesn't exist
                                        return TaskTileWidget(
                                          taskDetail: taskList[index],
                                          goalName: 'Error Goal title',
                                          goalTasksCompletedCount: 0,
                                          goalTasksTotalCount: 1,
                                        ); // Or any other loading indicator
                                      }
                                    } else {
                                      // Handle loading state
                                      return TaskTileWidget(
                                        taskDetail: taskList[index],
                                        goalName: 'Loading',
                                        goalTasksCompletedCount: 0,
                                        goalTasksTotalCount: 1,
                                      ); // Or any other loading indicator
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          }
        }));
  }

  List<TaskModel> _getEventsForDay(DateTime day) {
    return _firestoreData
        // .expand((data) => data['taskList'] ?? []) // Add a null check here
        .where((task) {
          DateTime startDate = _parseDate(task['startDate']);
          return isSameDay(startDate, day);
        })
        .map<TaskModel>((task) => TaskModel.fromJson(task))
        .toList();
  }

  DateTime _parseDate(String dateString) {
    List<String> parts = dateString.split('/');
    int month = int.parse(parts[0]);
    int day = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  List<TaskModel> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }
}
