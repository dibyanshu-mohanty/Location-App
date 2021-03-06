import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {
  static String generatedLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return "https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s-l+000($longitude,$latitude)/$longitude,$latitude,15,20/600x300?access_token=$apiKey";
  }

  static Future<String> getPlaceAddress(double long,double lat) async{
    final url = "https://api.mapbox.com/geocoding/v5/mapbox.places/$long,$lat.json?access_token=$apiKey";
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)['features'][0]['place_name'];
  }
}
