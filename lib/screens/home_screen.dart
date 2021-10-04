// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:location_app/providers/places.dart';
import 'package:location_app/screens/add_new_screen.dart';
import 'package:location_app/screens/detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("myPLACES"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
          ?  Center(child: CircularProgressIndicator(),)
          :  Consumer<Places>(
            child: Center(
              child: Text("No Places Added Yet !"),
            ),
            builder: (context, places, ch) {
              if (places.items.isEmpty) {
                return ch!;
              } else {
                return ListView.builder(
                  itemCount: places.items.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 4,
                    margin: EdgeInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: FileImage(places.items[index].image),
                        ),
                        title: Text(places.items[index].title),
                        subtitle: Text(places.items[index].location!.address,style: TextStyle(fontSize: 12.0),),
                        onTap: () {
                          Navigator.pushNamed(context, DetailScreen.routeName,arguments: places.items[index].id);
                        },
                      ),
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
