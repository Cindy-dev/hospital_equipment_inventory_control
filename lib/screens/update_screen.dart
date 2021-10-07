import 'dart:io';
import 'package:hospital_dbms/database/models/equipment.dart';
import 'package:hospital_dbms/providers/equipment_provider.dart';
import 'package:hospital_dbms/screens/homeScreen.dart';
import 'package:hospital_dbms/utils/Navigators.dart';
import 'package:hospital_dbms/widgets/DummyData/DummyData.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widgets/image_input.dart';

class UpdateScreen extends StatefulWidget {
  static const routeName = 'update-screen';

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: " ");
  final _quantityController = TextEditingController(text: " ");
  final _destController = TextEditingController(text: " ");
  final _presentController = TextEditingController(text: " ");

  String _pickedImage;

  var _editedEquipment = Equipment(
      id: null,
      name: '',
      quantity: '',
      image: '',
      dest: '',
      presentQuantity: '');

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final equipmentId = ModalRoute.of(context).settings.arguments as String;
      if (equipmentId != null) {
        _editedEquipment =
            Provider.of<EquipmentProvider>(context, listen: false)
                .findById(equipmentId);
        //   print("Our editable image is:" + _editedEquipment.image);

        setState(() {
          _nameController.text = _editedEquipment.name;
          _quantityController.text = _editedEquipment.quantity;
          _destController.text = _editedEquipment.dest;
          _presentController.text = _editedEquipment.presentQuantity;
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _saveEquipment() {
    if (_editedEquipment.id != null) {
      final equipment = _editedEquipment.copyWith(
          name: _nameController.text,
          // quantity: _quantityController.text,
          image: _pickedImage,
          dest: _destController.text,
          presentQuantity: _presentController.text);
      Provider.of<EquipmentProvider>(context, listen: false)
          .updateEquipment(_editedEquipment.id, equipment);
    } else {
      Provider.of<EquipmentProvider>(context, listen: false).addEquipment(
          _nameController.text,
          _quantityController.text,
          _pickedImage,
          _destController.text,
          _presentController.text);
    }
    popView(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Update Equipment',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 20, fontFamily: 'Avenir'),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
                icon: Icon(
                  Icons.save,
                  size: 30,
                ),
                onPressed: () {
                  _saveEquipment();
                  navigatePush(context, HomeScreen());
                }),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            padding: const EdgeInsets.all(10), //alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                          child: ImageInput(
                            onSelectImage: (v) {
                              setState(() {
                                _pickedImage = v;
                              });
                            },
                          )),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              cursorColor: Colors.deepOrangeAccent,
                              controller: _nameController,
                              decoration: InputDecoration(
                                  labelText: 'Equipment Name',
                                  labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.25),
                                    fontFamily: 'Avenir',
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                              validator: (String name) {
                                if (name.isEmpty) {
                                  return 'field cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),  
                              alignment: Alignment.centerLeft,
                                child: Text(
                              'Initial Quantity : ' + _quantityController.text,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 15, fontFamily: 'Avenir'),
                            )),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: Colors.deepOrangeAccent,
                              controller: _presentController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Equipment Present quantity',
                                  labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.25),
                                    fontFamily: 'Avenir',
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                              validator: (String quantity) {
                                if (quantity.isEmpty) {
                                  return 'field cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              cursorColor: Colors.deepOrangeAccent,
                              controller: _destController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 10,
                              decoration: InputDecoration(
                                  labelText: 'Equipment destination',
                                  labelStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.25),
                                    fontFamily: 'Avenir',
                                    fontSize: 14,
                                  ),
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //picture
                //home drop down box
              ],
            ),
          ),
        ),
      ),
    );
  }
}
