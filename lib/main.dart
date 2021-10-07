import 'package:flutter/material.dart';
import 'package:hospital_dbms/providers/equipment_provider.dart';
import 'package:hospital_dbms/screens/add_equipment_screen.dart';
import 'package:hospital_dbms/screens/equipment_detailScreen.dart';
import 'package:hospital_dbms/screens/homeScreen.dart';
import 'package:hospital_dbms/screens/loginPage.dart';
import 'package:hospital_dbms/screens/update_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value( 
      value: EquipmentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),  
        routes: {
          EquipmentDetailScreen.routeName: (ctx) => EquipmentDetailScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AddEquipmentScreen.routeName: (ctx) => AddEquipmentScreen(),
          UpdateScreen.routeName: (ctx) => UpdateScreen(),
        },
      ),
    );
  }
}
