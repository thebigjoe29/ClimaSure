import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

String api = "6615cde2e71055750d4cff726e30ecc6";
class variables {
  final  temperature;
  final  main; 
  final  wind;
  final  humidity;
  
  final maxtemp;
  final mintemp;
  final country;
  final description;
   

  variables(this.temperature, this.main, this.wind, this.humidity,this.maxtemp,this.mintemp,this.country,this.description);
}
var data;
//var temp;
bool success=false;

Future getData(String cityName, String api) async {
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$api&units=metric");
  var response = await http.get(url);
  if(response.statusCode==200){
  success=true;
  data = response.body;}
  if(data!=null){
    var temp=jsonDecode(data)["main"]["temp"];
    var main=jsonDecode(data)["weather"][0]["main"];
    var desc=jsonDecode(data)["weather"][0]["description"];
    var wind=jsonDecode(data)["wind"]["speed"];
    var humidity=jsonDecode(data)["main"]["humidity"];
    //var feels=jsonDecode(data)["main"]["feels_like"];
    var min=jsonDecode(data)["main"]["temp_min"];
    var max=jsonDecode(data)["main"]["temp_max"];
    var country=jsonDecode(data)["sys"]["country"];
    //var desc=jsonDecode(data)["weather"][0]["description"];
    //var sealevel=jsonDecode(data)["main"]["sea_level"];

    variables variable=variables(temp, main, wind, humidity,min,max,country,desc);
    return variable;
  }
  
  
}

// void getInfo() async {
//   List<double> latLon = await getLatLon("london");
//   double _lat = latLon[0];
//   double _lon = latLon[1];
//   getData(_lat, _lon);
// }
 

