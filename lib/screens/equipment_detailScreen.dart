import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_dbms/providers/equipment_provider.dart';
import 'package:hospital_dbms/screens/add_equipment_screen.dart';
import 'package:hospital_dbms/screens/homeScreen.dart';
import 'package:hospital_dbms/screens/update_screen.dart';
import 'package:hospital_dbms/utils/Navigators.dart';
import 'package:provider/provider.dart';

class EquipmentDetailScreen extends StatefulWidget {
  static const routeName = 'equipment-detail';
  const EquipmentDetailScreen({Key key}) : super(key: key);

  @override
  _EquipmentDetailScreenState createState() => _EquipmentDetailScreenState();
}

class _EquipmentDetailScreenState extends State<EquipmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EquipmentProvider>(context, listen: false);
    final id = ModalRoute.of(context).settings.arguments;
    final selectedEquipment =
        Provider.of<EquipmentProvider>(context, listen: false).findById(id);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text(selectedEquipment.name),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print(id);
                Navigator.of(context)
                    .pushNamed(UpdateScreen.routeName, arguments: id);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * .35,
              margin: EdgeInsets.all(30),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: MemoryImage(base64Decode(selectedEquipment.image))
                    //FileImage(selectedEquipment.image),
                    ),
              ),
            ),
            Text(
              selectedEquipment.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Center(
                child: Text( 
              'Initial Quantity : ' + selectedEquipment.quantity,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, fontFamily: 'Avenir'),
            )),
            SizedBox(height: 10,),
            Center(
                child: Text( 
              'present Quantity : ' + selectedEquipment.presentQuantity,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, fontFamily: 'Avenir'),
            )),
             SizedBox(height: 10,),
            Center(
                child: Text( 
              'Date of creation: ' + selectedEquipment.id.trim(),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, fontFamily: 'Avenir'),
            )),
            Card( 
              child: Container(
                width: MediaQuery.of(context).size.width * .9,
                padding: EdgeInsets.all(15), 
                decoration: BoxDecoration(shape: BoxShape.rectangle,),
                child: Text(
                  'Equipment distribution: \n'  +
                  selectedEquipment.dest,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.deepOrangeAccent.shade100,
        child: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            provider.deleteEquipment(id);
            navigatePush(context, HomeScreen());
          },
          iconSize: 30,
          color: Colors.red,
        ),
      ),
    );
  }
}
