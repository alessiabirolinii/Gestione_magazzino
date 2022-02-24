import 'package:flutter/material.dart';
import 'package:warehouse_app/models/warehouse.dart';

class WarehouseProvider with ChangeNotifier {
  List<Warehouse> warehouses = [
    Warehouse(id: 1, name: "Edificio A", address: "Via primo, 1"),
    Warehouse(id: 2, name: "Edificio B", address: "Via secondo, 2"),
    Warehouse(id: 3, name: "Edificio C", address: "Via terzo, 3"),
  ];

  Future<void> create(WarehouseCreateDTO warehouse) async {
    await Future.delayed(const Duration(seconds: 1), () {
      warehouses.add(
        Warehouse(
          id: warehouses.length + 1,
          name: warehouse.name,
          address: warehouse.address,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> delete(int code) async {
    await Future.delayed(const Duration(seconds: 1), () {
      warehouses.removeWhere((element) => element.id == code);
    });
    notifyListeners();
  }

  Future<void> update(Warehouse warehouse) async {
    await Future.delayed(const Duration(seconds: 1), () {
      final Warehouse tempWarehouse =
          warehouses.where((element) => element.id == warehouse.id).first;
      tempWarehouse.address = warehouse.address;
      tempWarehouse.name = warehouse.name;
    });

    notifyListeners();
  }
}
