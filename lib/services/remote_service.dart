import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_diet/common/entities/food.dart';
import 'package:my_diet/view/home/homecontroller.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import '../common/entities/exercise.dart';
import '../common/entities/searchingfood.dart';
import '../common/entities/userhealt.dart';

class RemoteService {
  Future<List<Food>?> getFoodsFromShortcut(String searchingQuery) async {
    var client = http.Client();
    //var query = searchingQuery;
    //var query2 = {"query": query};
    // 'content-type': 'application/x-www-form-urlencoded',
    var url = Uri.parse(
        "https://nutrition-by-api-ninjas.p.rapidapi.com/v1/nutrition?query=$searchingQuery");
    var response = await client.get(url, headers: {
      'X-RapidAPI-Key': "6f0370dce0msh71dc0a50b4101f6p1aa036jsnc2ac05370b28",
      'X-RapidAPI-Host': "nutrition-by-api-ninjas.p.rapidapi.com"
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return foodFromJson(json);
    } else {
      return null;
    }
  }

  Future<List<Exercise>?> getExercise(String query, int duration) async {
    var client = http.Client();

    var url = Uri.parse(
        "https://api.api-ninjas.com/v1/caloriesburned?activity=${query}&weight=${HomeController.weight.value}&duration=$duration");
    var response = await client.get(url, headers: {
      'X-API-Key': 'C2JCb8AqK8A+1OWlEQVH1Q==nELYCot0cFL4LBnD',
    });
    if (response.statusCode == 200) {
      var json = response.body;
      print("JSON: ${json}");
      return exerciseFromJson(json);
    } else {
      return null;
    }
  }

  Future<CustomerData?> postHealthInformation(
      int height,
      int weight,
      int goalWeight,
      String age,
      String gender,
      String goal,
      String exercise) async {
    var client = http.Client();
    var url = Uri.parse("https://fitness-api.p.rapidapi.com/fitness/");
    // var payload =
    //     "height=190&weight=80&age=30&gender=male&exercise=little&goal=maintenance&deficit=500&goalWeight=85";

    var information = {
      'height': height.toString(),
      'weight': weight.toString(),
      'goalWeight': goalWeight.toString(),
      'age': age,
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
      print("JSON: ${json}");
      //CustomerData example = customerDataFromJson(json);
      // print(
      //     "BMR: " + example.basalMetabolicRate.bmi!.calories.value.toString());
      //print(json);

      return customerDataFromJson(json);
    } else {
      return null;
    }
  }

  Future<SearchingFood?> getSearchingFood(String foodSearch) async {
    var query = foodSearch;
    var client = http.Client();
    var url = Uri.parse(
        "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/complexSearch?query=${query}&sort=calories&sortDirection=asc&minCarbs=0&maxCarbs=1000&minProtein=0&maxProtein=1000&minCalories=0&maxCalories=1000&minFat=0&maxFat=1000&number=10");
    var response = await client.get(
      url,
      headers: {
        'X-RapidAPI-Key': '6f0370dce0msh71dc0a50b4101f6p1aa036jsnc2ac05370b28',
        'X-RapidAPI-Host': 'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com'
      },
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return searchingFoodFromJson(json);
    } else {
      print("error");
      return null;
    }
  }

  getFoodfromBarCode(String code) async {
    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
      parametersList: <Parameter>[
        BarcodeParameter(code),
        const SortBy(option: SortOption.POPULARITY),
        const PageSize(size: 10)
      ],
      language: OpenFoodFactsLanguage.ENGLISH,
      version: ProductQueryVersion.v3,
    );

    SearchResult result = await OpenFoodAPIClient.searchProducts(
      const User(userId: '', password: ''),
      configuration,
    );
    if (result.products!.isNotEmpty) {
      return result.products!.first;
    }
  }

  Future<List<Product>?> getFoodfromFinding(String food) async {
    ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
      parametersList: <Parameter>[
        SearchTerms(terms: [food]),
        const SortBy(option: SortOption.POPULARITY),
        const PageSize(size: 10)
      ],
      language: OpenFoodFactsLanguage.ENGLISH,
      version: ProductQueryVersion.v3,
    );
    //   Product newProduct = Product(
    //     barcode: "0000000000000",
    //     productName: "Example Product",
    //     quantity: "200g",
    //     brands: "Example Brand",
    //     lang: OpenFoodFactsLanguage.ENGLISH,
    //     ingredientsText: "Ingredient 1, Ingredient 2, Ingredient 3",
    //     categories: "Category 1, Category 2"

    // );

    //Status resulttest = await OpenFoodAPIClient.saveProduct(OpenFoodAPIConfiguration.globalUser!, newProduct);
    SearchResult result = await OpenFoodAPIClient.searchProducts(
      OpenFoodAPIConfiguration.globalUser!,
      configuration,
    );
    return result.products;
  }
}
