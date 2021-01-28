
import 'package:flutter/material.dart';

import 'handle_widget.dart';

void main(){
  return runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(
            child: HandleWidget(

            ),
          ),
        ));
  }
}