import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Equipment {
  final String id;
  final String name;
  final String quantity;
  final String image;
  final String dest;
  final String presentQuantity;

  Equipment({
    @required this.id,
    @required this.name,
    @required this.quantity,
    @required this.image,
    @required this.dest,
    @required this.presentQuantity,
  });

  Equipment copyWith({
    String name,
    String quantity,
    String image,
    String dest,
    String presentQuantity,
  }) {
    return Equipment(
        id: this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        dest: dest ?? this.dest,
        quantity: quantity ?? this.quantity,
        presentQuantity: presentQuantity ?? this.presentQuantity);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "quantity": quantity,
        "image": image,
        "dest": dest,
        "presentQuantity": presentQuantity,
      };
}
