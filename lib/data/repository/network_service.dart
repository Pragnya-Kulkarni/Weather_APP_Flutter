import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {
  Future<Map<dynamic, dynamic>> fetchWeatherData(String cityName) async {
    final url = Uri.parse("https://api.openweathermap.org/data/2.5/"
        "weather?units=metric&appid=687e39409f49681cbe172402c5160cf7"
        "&q=$cityName");
    final response =
        await http.get(url, headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('Invalid city name');
    } else {
      throw Exception('Could\'nt fetch weather');
    }
  }
}
