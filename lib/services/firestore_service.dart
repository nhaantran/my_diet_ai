import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_diet/common/entities/untracked.dart';
import 'package:my_diet/services/remote_service.dart';
import 'package:my_diet/view/home/homecontroller.dart';

import '../common/entities/exercise.dart';
import '../common/entities/food.dart';
import '../common/entities/userhealt.dart';
import '../common/store/user.dart';

class FireStoreSerivce {
  final db = FirebaseFirestore.instance;
  final token = UserStore.to.token;

  addMeal(String session, List<Food> foodList) async {
    var dailyMealsColection =
        db.collection("mealsLog").doc(token).collection("dailyMeals");
    double totalCalories = 0.0;

    for (int i = 0; i < foodList.length; i++) {
      totalCalories += foodList[i].calories;
    }
    var dateDocRef = dailyMealsColection
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));
    // check whether if it existed or not
    var haveCreated = await dateDocRef.get();
    // have already exists
    if (haveCreated.exists) {
      if (haveCreated.data()!['calories_remaining'] != null) {
        await dateDocRef.set({
          "calories_eaten": FieldValue.increment(totalCalories),
          'calories_remaining': FieldValue.increment(-totalCalories),
        }, SetOptions(merge: true));
      }
    } else {
      // not exists
      await dateDocRef.set({
        "calories_eaten": FieldValue.increment(totalCalories),
        'calories_remaining': HomeController
                .userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value -
            totalCalories,
      }, SetOptions(merge: true));
    }

    var foodsCollection =
        dateDocRef.collection("meals").doc(session).collection("foods");

    for (int i = 0; i < foodList.length; i++) {
      foodsCollection.add(foodList[i].toJson());
    }
  }

  addWater(int amount) async {
    var dailyMealsColection =
        db.collection("mealsLog").doc(token).collection("dailyMeals");

    var dateDocRef = dailyMealsColection
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));

    await dateDocRef.set({
      "water_drinked": FieldValue.increment(amount.toDouble()),
    }, SetOptions(merge: true));
  }

  addExercise(Exercise exercise) async {
    var dailyMealsColection =
        db.collection("mealsLog").doc(token).collection("dailyMeals");

    var dateDocRef = dailyMealsColection
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));
    // check whether if it existed or not
    var haveCreated = await dateDocRef.get();
    // have already exists

    if (haveCreated.exists) {
      if (haveCreated.data()!['calories_remaining'] != null) {
        await dateDocRef.set({
          "calories_exercise": FieldValue.increment(exercise.totalCalories),
          'calories_remaining': FieldValue.increment(exercise.totalCalories),
        }, SetOptions(merge: true));
      }
    } else {
      // not exists
      await dateDocRef.set({
        "calories_exercise": FieldValue.increment(exercise.totalCalories),
        'calories_remaining': HomeController
                .userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value +
            exercise.totalCalories,
      }, SetOptions(merge: true));
    }

    var exerciseCollection = dateDocRef.collection("exercises");
    exerciseCollection.add(exercise.toJson());
  }

  addUntrackedExerciseCalories(UntrackedExercise exercise) async {
    var dailyMealsColection =
        db.collection("mealsLog").doc(token).collection("dailyMeals");

    var dateDocRef = dailyMealsColection
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));
    // check whether if it existed or not
    var haveCreated = await dateDocRef.get();
    // have already exists

    if (haveCreated.exists) {
      if (haveCreated.data()!['calories_remaining'] != null) {
        await dateDocRef.set({
          "calories_exercise_untracked":
              FieldValue.increment(exercise.calories),
          'calories_remaining': FieldValue.increment(exercise.calories),
        }, SetOptions(merge: true));
      }
    } else {
      // not exists
      await dateDocRef.set({
        "calories_exercise_untracked": FieldValue.increment(exercise.calories),
        'calories_remaining': HomeController
                .userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value +
            exercise.calories,
      }, SetOptions(merge: true));
    }

    var foodsCollection = dateDocRef.collection("untracked_exercises");
    foodsCollection.add(exercise.toJson());
  }

  addUntrackedFoodCalories(UntrackedFood food) async {
    var dailyMealsColection =
        db.collection("mealsLog").doc(token).collection("dailyMeals");

    var dateDocRef = dailyMealsColection
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));
    // check whether if it existed or not
    var haveCreated = await dateDocRef.get();
    // have already exists

    if (haveCreated.exists) {
      if (haveCreated.data()!['calories_remaining'] != null) {
        await dateDocRef.set({
          "calories_food_untracked": FieldValue.increment(food.calories),
          'calories_remaining': FieldValue.increment(-food.calories),
        }, SetOptions(merge: true));
      }
    } else {
      // not exists
      await dateDocRef.set({
        "calories_food_untracked": FieldValue.increment(food.calories),
        'calories_remaining': HomeController
                .userHealth!.totalDailyEnergyExpenditure.bmi!.calories.value -
            food.calories,
      }, SetOptions(merge: true));
    }

    var foodsCollection = dateDocRef.collection("untracked_meals");
    foodsCollection.add(food.toJson());
  }

  syncDataAfterUpdate(CustomerData userFromFireStore) async {
    var collectionRef = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .get();
    if (collectionRef.docs.isNotEmpty) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> day
          in collectionRef.docs) {
        if (day.data()["calories_remaining"] != null) {
          var oldGoal = day.data()["calories_remaining"] +
              (day.data()["calories_eaten"] ?? 0.0) +
              (day.data()["calories_food_untracked"] ?? 0.0) -
              (day.data()["calories_exercise"] ?? 0.0) -
              (day.data()["calories_exercise_untracked"] ?? 0.0);
         
          await day.reference.update({
            "calories_remaining": FieldValue.increment(userFromFireStore
                    .totalDailyEnergyExpenditure.bmi!.calories.value -
                oldGoal),
          });
          
        }
      }
    }
  }

  Future<CustomerData?> updateAgeUserHealth(int newAge) async {
    var userData = await db.collection("usersHealth").doc(token).get();
    if (userData.exists) {
      try {
        var userHealth = CustomerData.fromJson(userData.data()!);
        // update age here
        userHealth.age = newAge.toString();

        CustomerData? userFromFireStore = await RemoteService()
            .postHealthInformation(
                int.tryParse(userHealth.height) as int,
                int.tryParse(userHealth.weight) as int,
                int.tryParse(userHealth.goalWeight) as int,
                userHealth.age,
                userHealth.gender,
                userHealth.goal,
                userHealth.exercise);

        await userData.reference.update(userFromFireStore!.toJson());

        //sync all the data
        await syncDataAfterUpdate(userFromFireStore);
        return userFromFireStore;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }
  
  Future<CustomerData?> updateGoalWeightUserHealth(int newWeight) async {
    var userData = await db.collection("usersHealth").doc(token).get();
    if (userData.exists) {
      try {
        var userHealth = CustomerData.fromJson(userData.data()!);
        // update weight here
        userHealth.goalWeight = newWeight.toString();

        CustomerData? userFromFireStore = await RemoteService()
            .postHealthInformation(
                int.tryParse(userHealth.height) as int,
                int.tryParse(userHealth.weight) as int,
                int.tryParse(userHealth.goalWeight) as int,
                userHealth.age,
                userHealth.gender,
                userHealth.goal,
                userHealth.exercise);

        await userData.reference.update(userFromFireStore!.toJson());

        //sync all the data
        await syncDataAfterUpdate(userFromFireStore);
        return userFromFireStore;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  Future<CustomerData?> updateHeightUserHealth(int newHeight) async {
    var userData = await db.collection("usersHealth").doc(token).get();
    if (userData.exists) {
      try {
        var userHealth = CustomerData.fromJson(userData.data()!);
        // update weight here
        userHealth.height = newHeight.toString();

        CustomerData? userFromFireStore = await RemoteService()
            .postHealthInformation(
                int.tryParse(userHealth.height) as int,
                int.tryParse(userHealth.weight) as int,
                int.tryParse(userHealth.goalWeight) as int,
                userHealth.age,
                userHealth.gender,
                userHealth.goal,
                userHealth.exercise);

        await userData.reference.update(userFromFireStore!.toJson());

        //sync all the data
        await syncDataAfterUpdate(userFromFireStore);
        return userFromFireStore;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }
  Future<CustomerData?> updateWeightUserHealth(int newWeight) async {
    var userData = await db.collection("usersHealth").doc(token).get();
    if (userData.exists) {
      try {
        var userHealth = CustomerData.fromJson(userData.data()!);
        // update weight here
        userHealth.weight = newWeight.toString();

        CustomerData? userFromFireStore = await RemoteService()
            .postHealthInformation(
                int.tryParse(userHealth.height) as int,
                int.tryParse(userHealth.weight) as int,
                int.tryParse(userHealth.goalWeight) as int,
                userHealth.age,
                userHealth.gender,
                userHealth.goal,
                userHealth.exercise);

        await userData.reference.update(userFromFireStore!.toJson());

        //sync all the data
        await syncDataAfterUpdate(userFromFireStore);
        return userFromFireStore;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  Future<List<Food>?> getListOfFood(DateTime date, String session) async {
    var mealsCollection = db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(date))
        .collection("meals")
        .doc(session);
    var foodsCollection = await mealsCollection.collection("foods").get();

    if (foodsCollection.docs.isNotEmpty) {
      var foodsList = <Food>[];
      for (int i = 0; i < foodsCollection.docs.length; i++) {
        foodsList.add(Food.fromJson(foodsCollection.docs[i].data()));
      }
      return foodsList;
    }
    return [];
  }

  Future<List<Exercise>?> getListOfExercise(DateTime date) async {
    var exercisesCollection = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(date))
        .collection("exercises")
        .get();

    if (exercisesCollection.docs.isNotEmpty) {
      var exercisesList = <Exercise>[];
      for (int i = 0; i < exercisesCollection.docs.length; i++) {
        exercisesList
            .add(Exercise.fromJson(exercisesCollection.docs[i].data()));
      }
      return exercisesList;
    }
    return [];
  }

  Future<List<UntrackedFood>?> getListOfUntrackedFood(DateTime date) async {
    var untrackedCollection = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(date))
        .collection("untracked_meals")
        .get();
    if (untrackedCollection.docs.isNotEmpty) {
      var untrackedFoodsList = <UntrackedFood>[];
      for (int i = 0; i < untrackedCollection.docs.length; i++) {
        untrackedFoodsList
            .add(UntrackedFood.fromJson(untrackedCollection.docs[i].data()));
      }
      return untrackedFoodsList;
    }
    return [];
  }

  Future<List<UntrackedExercise>?> getListOfUntrackedExercise(
      DateTime date) async {
    var untrackedCollection = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(date))
        .collection("untracked_exercises")
        .get();
    if (untrackedCollection.docs.isNotEmpty) {
      var untrackedFoodsList = <UntrackedExercise>[];
      for (int i = 0; i < untrackedCollection.docs.length; i++) {
        untrackedFoodsList.add(
            UntrackedExercise.fromJson(untrackedCollection.docs[i].data()));
      }
      return untrackedFoodsList;
    }
    return [];
  }

  Future<double> getWaterNeeded(DateTime date) async {
    var mealsData = await db.collection("usersHealth").doc(token).get();

    if (mealsData.exists) {
      return mealsData.data()!['waterIntake'];
    }
    return 0;
  }

  Future<double> getWaterDrinked(DateTime date) async {
    var mealsData = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(date))
        .get();
    if (mealsData.exists) {
      if (mealsData.data()!['water_drinked'] != null) {
        return mealsData.data()!['water_drinked'];
      }
    }
    return 0;
  }

  Future<double> getCaloriesEaten(DateTime date) async {
    var mealsData = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(date))
        .get();
    var caloriesEaten = 0.0;
    var caloriesUntracked = 0.0;
    if (mealsData.exists) {
      if (mealsData.data()!['calories_eaten'] != null) {
        caloriesEaten = mealsData.data()!['calories_eaten'];
      }
      if (mealsData.data()!['calories_food_untracked'] != null) {
        caloriesUntracked = mealsData.data()!['calories_food_untracked'];
      }
    }
    return caloriesEaten + caloriesUntracked;
  }

  Future<int> getCaloriesExercise(DateTime date) async {
    var mealsData = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(date))
        .get();
    var caloriesExecise = 0;
    var caloriesUntracked = 0;
    if (mealsData.exists) {
      if (mealsData.data()!['calories_exercise'] != null) {
        caloriesExecise = mealsData.data()!['calories_exercise'];
      }
      if (mealsData.data()!['calories_exercise_untracked'] != null) {
        caloriesUntracked = mealsData.data()!['calories_exercise_untracked'];
      }
    }
    return caloriesExecise + caloriesUntracked;
  }

  Future<int> getStreaksCount() async {
    // check is not empty
    var collectionRef = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .get();
    if (collectionRef.docs.isNotEmpty) {
      var querySnapshot = await db
          .collection("mealsLog")
          .doc(token)
          .collection("dailyMeals")
          .get();
      // if (DateTime.parse(querySnapshot.docs.last.id)
      //         .isAtSameMomentAs(DateTime.now()) ||
      //     DateTime.parse(querySnapshot.docs.last.id).isAtSameMomentAs(
      //         DateTime.now().subtract(const Duration(days: 1)))) {

      //         }
      List<DateTime> dates = [];
      for (QueryDocumentSnapshot<Map<String, dynamic>> day
          in querySnapshot.docs) {
        dates.add(DateFormat('dd-MM-yyyy').parse(day.id));
      }
      DateTime currentDate = DateTime.now();
      DateTime yesterday = currentDate.subtract(const Duration(days: 1));

      int count = 0;
      DateTime? previousDate;

      for (var date in dates) {
        if (previousDate != null) {
          if (date.difference(currentDate).inDays <= 1) {
            // Date is consecutive with the previous date
            count++;
          } else {
            // Date is not consecutive, reset the count
            count = 1;
          }
        } else {
          // First date in the list, start counting
          count = 1;
        }

        previousDate = date;

        if (date.isAfter(yesterday)) {
          // Stop counting if the date is after yesterday
          break;
        }
      }
      return count;
    }
    return 0;
  }

  Future<double> getCaloriesRemaining(DateTime date) async {
    var mealsData = await db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(date))
        .get();
    if (mealsData.exists) {
      if (mealsData.data()!['calories_remaining'] != null) {
        return mealsData.data()!['calories_remaining'];
      }
    }
    return 0.0;
  }

  deleteFood(Food deletedFood, String session) async {
    var caloriesDeletedFood = 0.0;

    var dateDocRef = db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));

    // delete food
    var foodsCollection =
        dateDocRef.collection("meals").doc(session).collection("foods");

    var querySnapshot =
        await foodsCollection.where("name", isEqualTo: deletedFood.name).get();

    for (var document in querySnapshot.docs) {
      caloriesDeletedFood += document.data()['calories'];
      document.reference.delete();
    }

    // update calories for that date
    // check whether if it existed or not
    var haveCreated = await dateDocRef.get();

    if (haveCreated.exists) {
      await dateDocRef.set({
        "calories_eaten": FieldValue.increment(-caloriesDeletedFood),
        'calories_remaining': FieldValue.increment(caloriesDeletedFood),
      }, SetOptions(merge: true));
    }
  }

  deleteUntrackedFood(UntrackedFood deletedFood) async {
    var caloriesDeletedFood = 0.0;

    var dateDocRef = db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));

    // delete food
    var foodsCollection = dateDocRef.collection("untracked_meals");

    var querySnapshot = await foodsCollection
        .where("description", isEqualTo: deletedFood.description)
        .get();

    for (var document in querySnapshot.docs) {
      caloriesDeletedFood += document.data()['calories'];
      document.reference.delete();
    }

    // update calories for that date
    // check whether if it existed or not
    var haveCreated = await dateDocRef.get();

    if (haveCreated.exists) {
      await dateDocRef.set({
        "calories_food_untracked": FieldValue.increment(-caloriesDeletedFood),
        'calories_remaining': FieldValue.increment(caloriesDeletedFood),
      }, SetOptions(merge: true));
    }
  }

  deleteExercise(Exercise deletedExercise) async {
    var caloriesDeletedExercise = 0.0;

    var dateDocRef = db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));

    // delete food
    var foodsCollection = dateDocRef.collection("exercises");

    var querySnapshot = await foodsCollection
        .where("name", isEqualTo: deletedExercise.name)
        .get();

    for (var document in querySnapshot.docs) {
      caloriesDeletedExercise += document.data()['total_calories'];
      document.reference.delete();
    }

    // update calories for that date
    // check whether if it existed or not
    var haveCreated = await dateDocRef.get();

    if (haveCreated.exists) {
      await dateDocRef.set({
        "calories_exercise": FieldValue.increment(-caloriesDeletedExercise),
        'calories_remaining': FieldValue.increment(-caloriesDeletedExercise),
      }, SetOptions(merge: true));
    }
  }

  deleteUntrackedExercise(UntrackedExercise deletedExercise) async {
    var caloriesDeletedExercise = 0.0;

    var dateDocRef = db
        .collection("mealsLog")
        .doc(token)
        .collection("dailyMeals")
        .doc(DateFormat('dd-MM-yyyy').format(DateTime.now()));

    // delete food
    var foodsCollection = dateDocRef.collection("untracked_exercises");

    var querySnapshot = await foodsCollection
        .where("description", isEqualTo: deletedExercise.description)
        .get();

    for (var document in querySnapshot.docs) {
      caloriesDeletedExercise += document.data()['calories'];
      document.reference.delete();
    }

    // update calories for that date
    // check whether if it existed or not
    var haveCreated = await dateDocRef.get();

    if (haveCreated.exists) {
      await dateDocRef.set({
        "calories_exercise_untracked  ":
            FieldValue.increment(-caloriesDeletedExercise),
        'calories_remaining': FieldValue.increment(-caloriesDeletedExercise),
      }, SetOptions(merge: true));
    }
  }
}
