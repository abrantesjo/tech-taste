import 'package:flutter/material.dart';
import 'package:myapp/model/dish.dart';

class BagProvider extends ChangeNotifier {
  List<Dish> dishesOnBag = [];

  addAllDishes(List<Dish> dishes) {
    dishesOnBag.addAll(dishes);
    notifyListeners(); //todo mundo que tiver ouvindo o bag provider vai atualizar a interface
  }

  removeDish(Dish dish) {
    dishesOnBag.remove(dish);
    notifyListeners();
  }

  clearBag() {
    dishesOnBag.clear();
    notifyListeners();
  }

  Map<Dish, int> getMapByAmount() {
    Map<Dish, int> mapResult = {};

    for (Dish dish in dishesOnBag) {
      if (mapResult[dish] == null) {
        //se nao tiver na lista, ele adiciona
        mapResult[dish] = 1;
      } else {
        //se ja tiver na lista, ele soma mais um
        mapResult[dish] = mapResult[dish]! + 1;
      }
    }

    return mapResult;
  }
}
