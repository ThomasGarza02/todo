import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  final String categorytxt;
  Category({Key? key, required this.categorytxt}) : super(key: key);
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isExtended = false;
  final List<Widget> _taskList = [];
  void _isextended(bool isextended) {
    _isExtended = isextended;

    setState(() {
      _isExtended = isextended ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 200),
          child: FilledButton(
            onPressed: () {
              _isextended(_isExtended);
            },
            style: FilledButton.styleFrom(
                backgroundColor: const Color(0xfff5f5f5),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: Row(children: [
              Text(
                widget.categorytxt,
                style: const TextStyle(color: Color(0xff0f4c9f)),
              ),
              const Spacer(),
              Icon(
                _isExtended ? Icons.remove : Icons.add,
                color: const Color(0xff0f4c9f),
              )
            ]),
          ),
        ),
        Visibility(
          visible: _isExtended,
          child: Column(
            children: _taskList,
          ),
        ),
        Visibility(
          visible: _isExtended,
          child: FilledButton(
              onPressed: () {
                setState(() {
                  _taskList.add(Task());
                });
              },
              style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xfff5f5f5),
                  fixedSize: const Size(120, 10),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              child: const Icon(
                Icons.add,
                color: Color(0xff0f4c9f),
              )),
        ),
      ],
    );
  }
}

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late TextEditingController taskController;
  late TextEditingController dueByController;
  late TextEditingController priorityController;
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

  String _taskName = "Task";
  String _dueDate = "due by";
  String _priorityLvl = "Priority lvl";
  bool _done = false;
  void _check(bool checkedBox) {
    _done = checkedBox;

    setState(() {
      _done = _done ? false : true;
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
          final form = await openDialog();
          if (form == null || form.isEmpty) return;

          setState(() {
            _taskName = form['task'] == "" ? _taskName : form['task'];
            _dueDate = form['dueBy'] == "" ? _dueDate : form['dueBy'];
            _priorityLvl =
                form['priority'] == "" ? _priorityLvl : form['priority'];
          });
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
          actions: [TextButton(onPressed: submit, child: const Text("done"))]));

  void submit() {
    Navigator.of(context).pop({
      'task': taskController.text,
      'dueBy': dueByController.text,
      'priority': priorityController.text
    });
  }
}
