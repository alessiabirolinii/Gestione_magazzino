import 'package:flutter/material.dart';
import 'package:warehouse_app/models/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> categories = [
    Category(code: 1, name: "Sport"),
    Category(code: 1, name: "Arredamento"),
    Category(code: 3, name: "Moto e Macchine"),
    Category(code: 4, name: "Elettrodomestici"),
    Category(code: 5, name: "Per la casa"),
    Category(code: 6, name: "Telefonia"),
    Category(code: 7, name: "Utensili"),
  ];

  Future<void> create(CategoryCreateDTO category) async {
    await Future.delayed(const Duration(seconds: 1), () {
      categories.add(
        Category(
          code: categories.length + 1,
          name: category.name,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> delete(int code) async {
    await Future.delayed(const Duration(seconds: 1), () {
      categories.removeWhere((element) => element.code == code);
    });
    notifyListeners();
  }

  Future<void> update(Category category) async {
    await Future.delayed(const Duration(seconds: 1), () {
      for (Category item in categories) {
        if (item.code == category.code) {
          item.name = category.name;
          break;
        }
      }
    });
    notifyListeners();
  }
}
