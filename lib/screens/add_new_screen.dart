// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location_app/models/place.dart';
import 'package:location_app/providers/places.dart';
import 'package:location_app/widgets/image_input.dart';
import 'package:location_app/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/AddPlaceScreen";
  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat,double long){
    _pickedLocation = PlaceLocation(lat: lat, long: long);
  }
  void _savePlace() {
    if (_titleController.text == "" || _pickedImage == null || _pickedLocation == null) {
      // ScaffoldMessengerState().showSnackBar(SnackBar(
      //   content: Text("Please Add All Required Fields !"),
      //   duration: Duration(seconds: 3),
      // ));
      return;
    }
    Provider.of<Places>(context,listen: false).addPlaces(_titleController.text, _pickedImage,_pickedLocation);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("addPLACE"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Title",
                        ),
                        controller: _titleController,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      ImageInput(_selectImage),
                      SizedBox(
                        height: 20.0,
                      ),
                      LocationInput(_selectPlace),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
              ),
              onPressed:_savePlace,
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: Text(
                "ADD PLACE",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ));
  }
}
