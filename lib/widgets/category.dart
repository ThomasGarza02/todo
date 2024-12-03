import 'package:flutter/material.dart';
import './task.dart';

class Category extends StatefulWidget {
  final String categorytxt;
  Category({Key? key, required this.categorytxt}) : super(key: key);
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool _isExtended = false;
  final List<Task> _taskList = [];
  void _isextended(bool isextended) {
    _isExtended = isextended;
    setState(() {
      _isExtended = isextended ? false : true;
    });
  }

  void _removeTask(int index) {
    setState(() {
      _taskList.removeAt(index); // Remove widget at the specified index
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
        Offstage(
          offstage: !_isExtended,
          child: Column(
            children: _taskList,
          ),
        ),
        Visibility(
          visible: _isExtended,
          child: FilledButton(
              onPressed: () {
                setState(() {
                  _taskList.add(Task(
                    index: 1,
                  ));
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
