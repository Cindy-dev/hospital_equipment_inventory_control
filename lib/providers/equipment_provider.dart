import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hospital_dbms/database/db_helpers.dart';
import 'package:hospital_dbms/database/models/equipment.dart';

class EquipmentProvider with ChangeNotifier {
  EquipmentProvider() {
    fetchAndSetEquipment();
  }
  List<Equipment> _items = [];

  List<Equipment> get items {
    return [..._items];
  }

  Equipment findById(String id) {
    return _items.firstWhere((contacts) => contacts.id == id);
  }

  addEquipment(String pickedName, String pickedQuantity, String pickedImage,
      String pickedDest, String pickedpresentQuantity) {
    final newEquipment = Equipment(
      id: DateTime.now().toString(),
      name: pickedName,
      quantity: pickedQuantity,
      image: pickedImage,
      dest: pickedDest,
      presentQuantity: pickedpresentQuantity,
    );
    if(pickedName.isEmpty || pickedImage.isEmpty|| pickedQuantity.isEmpty){
      
    }
    _items.add(newEquipment);
    notifyListeners();
    DBHelpers.insert("hospital_equipment", {
      'id': newEquipment.id,
      'name': newEquipment.name,
      'quantity': newEquipment.quantity,
      'image': newEquipment.image,
      'dest': newEquipment.dest,
      'presentQuantity': newEquipment.presentQuantity,
    });
  }

  // sortContacts(String firstName){
  //   _items.sort((a, b)=> a.firstName.compareTo(b.firstName));
  // }
  void deleteEquipment(String id) async {
    //_items.removeWhere((element) => false)
    await DBHelpers.delete(id);
    notifyListeners();
  }

  updateEquipment(String id, Equipment equipment) async {
    final newEquipment = Equipment(
      id: DateTime.now().toString(),
      name: equipment.name,
      quantity: equipment.quantity,
      image: equipment.image,
      dest: equipment.dest,
      presentQuantity: equipment.presentQuantity,
    );
    notifyListeners();
    DBHelpers.update(equipment);
  }

  Future<void> fetchAndSetEquipment() async {
    final dataList = await DBHelpers.getData('hospital_equipment');
    _items = dataList
        .map((item) => Equipment(
              id: item['id'],
              name: item['name'],
              quantity: item['quantity'],
              image: item['image'],
              dest: item['dest'],
              presentQuantity: item['presentQuantity'],
            ))
        .toList();
    notifyListeners();
  }
}
