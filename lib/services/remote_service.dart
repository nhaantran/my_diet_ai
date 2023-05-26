import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:openfoodfacts/openfoodfacts.dart';

import '../common/entities/exercise.dart';
import '../common/entities/userhealt.dart';

class RemoteService {
  Future<List<String>?> getFoods() async {
    var client = http.Client();
    var query = "100g baked chicken breast";
    //var query2 = {"query": query};
    // 'content-type': 'application/x-www-form-urlencoded',
    var url = Uri.parse(
        "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=$query");
    var response = await client.get(url, headers: {
      'X-RapidAPI-Key': "6f0370dce0msh71dc0a50b4101f6p1aa036jsnc2ac05370b28",
      'X-RapidAPI-Host': "nutrition-by-api-ninjas.p.rapidapi.com"
    });
    if (response.statusCode == 200) {
      print(response.body);
      print("success");
    } else {
      print("failed");
    }
  }

  Future<List<Exercise>?> getExercise(String query) async {
    var client = http.Client();
    var url = Uri.parse(
        "https://api.api-ninjas.com/v1/caloriesburned?activity=${query}");
    var response = await client.get(url, headers: {
      'X-API-Key': 'C2JCb8AqK8A+1OWlEQVH1Q==nELYCot0cFL4LBnD',
    });
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return exerciseFromJson(json);
    } else {
      print("failed");
    }
  }

  Future<CustomerData?> postHealthInformation(
      int height,
      int weight,
      int goalWeight,
      int age,
      String gender,
      String goal,
      String exercise) async {
    var client = http.Client();
    var url = Uri.parse("https://fitness-api.p.rapidapi.com/fitness/");
    var payload =
        "height=190&weight=80&age=30&gender=male&exercise=little&goal=maintenance&deficit=500&goalWeight=85";

    var information = {
      'height': height.toString(),
      'weight': weight.toString(),
      'goalWeight': goalWeight.toString(),
      'age': age.toString(),
      'gender': gender,
      'goal': goal,
      'exercise': exercise
    };
    var response = await client.post(url,
        headers: {
          'content-type': 'application/json',
          'X-RapidAPI-Key':
              "6f0370dce0msh71dc0a50b4101f6p1aa036jsnc2ac05370b28",
          'X-RapidAPI-Host': "fitness-api.p.rapidapi.com"
        },
        body: json.encode(information));
    if (response.statusCode == 201 || response.statusCode == 200) {
      var json = response.body;
      //CustomerData example = customerDataFromJson(json);
      // print(
      //     "BMR: " + example.basalMetabolicRate.bmi!.calories.value.toString());
      //print(json);
      return customerDataFromJson(json);
    } else {
      print("failed: " + response.statusCode.toString());
      return null;
    }
  }

  Future<List<Product>?> getFood(String food) async {
    // ProductQueryConfiguration config = ProductQueryConfiguration(
    //   '5449000131805',
    //   version: ProductQueryVersion.v3,
    // );
    // ProductResultV3 product = await OpenFoodAPIClient.getProductV3(config);
    // print(product.product?.productName); // Coca Cola Zero
    // print(product.product?.brands); // Coca-Cola
    // print(product.product?.quantity); // 330ml
    // print(product.product?.nutriments
    //     ?.getValue(Nutrient.salt, PerSize.oneHundredGrams)); // 0.0212
    // print(product.product?.additives?.names); // [E150d, E338, E950, E951]
    // print(product.product?.allergens?.names);

    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
      parametersList: <Parameter>[
        SearchTerms(terms: [food]),
      ],
      version: ProductQueryVersion.v3,
    );

    SearchResult result = await OpenFoodAPIClient.searchProducts(
      User(userId: '', password: ''),
      configuration,
    );
    print(result.products?[0].productName);
    return result.products;
    
  }
}
