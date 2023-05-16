import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<String>?> getFoods() async {
    var client = http.Client();
    var query = "100g baked chicken breast";
    //var query2 = {"query": query};
    var uri = Uri.parse(
        "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=$query");
    var response = await client.get(uri, headers: {
      'X-RapidAPI-Key': "6f0370dce0msh71dc0a50b4101f6p1aa036jsnc2ac05370b28",
      'X-RapidAPI-Host': "nutrition-by-api-ninjas.p.rapidapi.com"
    });
    if (response.statusCode == 200) {
      print("success");
    } else {
      print("failed");
    }
  }
}
