import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final int index;
  const Task({super.key, required this.index});
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late TextEditingController taskController;
  late TextEditingController dueByController;
  late TextEditingController priorityController;
  String _taskName = "Task";
  String _dueDate = "due by";
  String _priorityLvl = "Priority lvl";
  bool _done = false;
  @override
  void initState() {
    super.initState();
    taskController = TextEditingController();
    dueByController = TextEditingController();
    priorityController = TextEditingController();
  }

  @override
  void dispose() {
    taskController.dispose();
    dueByController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  void _check(bool checkedBox) {
    _done = checkedBox;
    setState(() {
      _done = _done ? false : true;
    });
  }

  void _edit(String taskList, String dueDate, String priorityLvl) async {
    _taskName = taskList;
    _dueDate = dueDate;
    _priorityLvl = priorityLvl;
    final form = await openDialog();
    if (form == null || form.isEmpty) return;

    setState(() {
      _taskName = form['task'] == "" ? _taskName : form['task'];
      _dueDate = form['dueBy'] == "" ? _dueDate : form['dueBy'];
      _priorityLvl = form['priority'] == "" ? _priorityLvl : form['priority'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 20),
      child: FilledButton(
        onPressed: () {
          _check(_done);
        },
        onLongPress: () async {
          _edit(_taskName, _dueDate, _priorityLvl);
        },
        style: FilledButton.styleFrom(
            backgroundColor: const Color(0xfff5f5f5),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        child: Row(children: [
          Icon(
            _done ? Icons.check_box_outlined : Icons.check_box_outline_blank,
            color: const Color(0xff0f4c9f),
          ),
          Text(
            _taskName,
            style: const TextStyle(color: Color(0xff0f4c9f)),
          ),
          Text(
            _dueDate,
            style: const TextStyle(color: Color(0xff0f4c9f)),
          ),
          Text(
            _priorityLvl,
            style: const TextStyle(color: Color(0xff0f4c9f)),
          ),
        ]),
      ),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: 'Task'),
                  controller: taskController,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Due by'),
                  controller: dueByController,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'Priority lvl'),
                  controller: priorityController,
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => submit, child: const Text("done"))
            ],
          ));

  void submit() {
    Navigator.of(context).pop({
      'task': taskController.text,
      'dueBy': dueByController.text,
      'priority': priorityController.text
    });
  }
}
