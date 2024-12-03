import 'package:flutter/material.dart';
import './widgets/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO DO LIST',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: Color(0xff112236),
            titleTextStyle: TextStyle(
              color: Color(0xffd29c44),
              fontSize: 32,
            )),
        scaffoldBackgroundColor: const Color(0xffcddeee),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'TODO List'),
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
  final TextEditingController _controller = TextEditingController();
  final List<Widget> _categoryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      controller: _controller,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(left: 15, right: 15),
                        hintText: "Add new category",
                        fillColor: Color(0xfff5f5f5),
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xff0f4c9f),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff0f4c9f),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff0f4c9f),
                              width: 3,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                      ),
                    ),
                  ),
                  FilledButton(
                      onPressed: () {
                        setState(() {
                          _categoryList
                              .add(Category(categorytxt: _controller.text));
                        });
                      },
                      style: FilledButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xff0f4c9f),
                            width: 3,
                          ),
                          backgroundColor: const Color(0xfff5f5f5),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)))),
                      child: const Icon(
                        Icons.add,
                        color: Color(0xff0f4c9f),
                      ))
                ],
              ),
            ),
            Column(children: _categoryList),
          ],
        ),
      ),
    );
  }
}
