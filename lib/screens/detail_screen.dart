import 'package:flutter/material.dart';
import 'package:location_app/providers/places.dart';
import 'package:location_app/screens/map_screen.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = "/DetailScreen";
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace =
        Provider.of<Places>(context, listen: false).findById(id.toString());
    return Scaffold(
        appBar: AppBar(
          title: const Text("MAP"),
        ),
        body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedPlace.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              selectedPlace.location!.address,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => MapScreen(
                                initialLocation: selectedPlace.location!,
                                isSelecting: false,
                              )));
                },
                child: Text(
                  "VIEW ON MAP",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                )),
          ],
        ));
  }
}
