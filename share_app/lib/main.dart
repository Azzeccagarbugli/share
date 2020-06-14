import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Share/views/seed.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple[600],
        disabledColor: Colors.purple[100],
        brightness: Brightness.light,
        buttonColor: Colors.grey[900],
        dividerColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePageView(),
    );
  }
}
