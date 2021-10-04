import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location_app/helpers/location_helper.dart';
import 'package:location_app/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput(this.onSelectPlace, {Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageURL = "";

  void _showPreview(double lat, double long) {
    final staticMapURL = LocationHelper.generatedLocationPreviewImage(
        latitude: lat, longitude: long);
    setState(() {
      _previewImageURL = staticMapURL;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final userLoc = await Location().getLocation();
      _showPreview(userLoc.latitude!, userLoc.longitude!);
      widget.onSelectPlace(userLoc.latitude, userLoc.longitude);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: Text(e.toString()),
                insetAnimationDuration: const Duration(seconds: 2),
              ));
    }
  }

  Future<void> selectOnMap() async {
    final LatLng? selectedLocation = await Navigator.push<LatLng>(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => const MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
          child: _previewImageURL == ""
              ? const Text(
                  "No Location Found",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageURL,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
                onPressed: () {
                  _getCurrentLocation();
                },
                icon: const Icon(Icons.gps_fixed),
                label: Text(
                  "Current Location",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
            TextButton.icon(
                onPressed: selectOnMap,
                icon: const Icon(Icons.location_on),
                label: Text(
                  "Select On Map",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                )),
          ],
        )
      ],
    );
  }
}
