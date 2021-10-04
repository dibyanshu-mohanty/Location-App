import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:location_app/helpers/location_helper.dart';
import 'package:location_app/models/place.dart';
import 'package:location_app/helpers/db_helper.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlaces(String title, File? pickedImage, PlaceLocation? pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(pickedLocation!.long, pickedLocation.lat);
    final updatedLocation = PlaceLocation(lat: pickedLocation.lat, long: pickedLocation.long,address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        location: updatedLocation,
        image: pickedImage!);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.lat,
      'loc_lng': newPlace.location!.long,
      'address': newPlace.location!.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            location: PlaceLocation(lat: item['loc_lat'],long: item['loc_lng'],address: item['address']),
            title: item['title'],
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }

  Place findById(String id){
    return _items.firstWhere((element) => element.id == id);
  }
}
