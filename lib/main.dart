// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:location_app/screens/add_new_screen.dart';
import 'package:location_app/screens/detail_screen.dart';
import 'package:location_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/places.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo,accentColor: Colors.amber)
        ),
        home: HomeScreen(),
        routes: {
          AddPlaceScreen.routeName: (context) => AddPlaceScreen(),
          DetailScreen.routeName: (context) => DetailScreen(),
        },
      ),
    );
  }
}