import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

String api = "";
var data;
var temp;
bool success=false;
// tp = jsonDecode(data)["weather"][0]["description"];
//      tp2 = jsonDecode(data)["main"]["temp"];

// Future<List<double>> getLatLon(String cityName) async {
//   var url = Uri.parse(
//       "http://api.openweathermap.org/geo/1.0/direct?q=$cityName&appid=$api");
//   var response = await http.get(url);
//   var data = response.body;
//   double lat = jsonDecode(data)[0]["lat"];
//   double lon = jsonDecode(data)[0]["lon"];
//   return [lat, lon];
// }

Future getTemp(String cityName, String api) async {
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$api&units=metric");
  var response = await http.get(url);
  if(response.statusCode==200){
  success=true;
  data = response.body;}
  if(data!=null)
  temp = jsonDecode(data)["main"]["temp"];
  return temp;
}

// void getInfo() async {
//   List<double> latLon = await getLatLon("london");
//   double _lat = latLon[0];
//   double _lon = latLon[1];
//   getData(_lat, _lon);
// }


