import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital_dbms/database/db_helpers.dart';
import 'package:hospital_dbms/database/models/equipment.dart';
import 'package:hospital_dbms/providers/equipment_provider.dart';
import 'package:hospital_dbms/screens/add_equipment_screen.dart';
import 'package:hospital_dbms/screens/equipment_detailScreen.dart';
import 'package:hospital_dbms/utils/Navigators.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home';
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Equipment> items = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EquipmentProvider>().fetchAndSetEquipment();
      items = context.read<EquipmentProvider>().items;
      print(items);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Delight Hospital',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  navigatePush(context, AddEquipmentScreen());
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: EquipmentSearch(this.items));
                }),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //SizedBox(height: 50,),
                FutureBuilder(
                  future: Provider.of<EquipmentProvider>(context, listen: false)
                      .fetchAndSetEquipment(),
                  builder: (ctx, snapShot) => snapShot.connectionState ==
                          ConnectionState.waiting
                      ? Column(
                          children: [
                            SizedBox(
                              height: queryData.size.height * 0.4,
                            ),
                            Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.deepOrangeAccent,
                            )),
                          ],
                        )
                      : Consumer<EquipmentProvider>(
                          child: Column(children: [
                            SizedBox(
                              height: queryData.size.height * 0.4,
                            ),
                            Center(
                              child: const Text(
                                'No equipment available at the moment',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Avenir', fontSize: 20),
                              ),
                            )
                          ]),
                          builder: (ctx, equipmentProvider, ch) =>
                              equipmentProvider.items.length <= 0
                                  ? ch
                                  : GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 0,
                                      ),
                                      physics: BouncingScrollPhysics(),
                                      itemCount: equipmentProvider.items.length,
                                      itemBuilder: (ctx, i) => GridTile(
                                        child: Card(
                                          elevation: 2,
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                EquipmentDetailScreen.routeName,
                                                arguments: equipmentProvider
                                                    .items[i].id,
                                              );
                                            },
                                            child: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        .1,
                                                    margin: EdgeInsets.all(15), 
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: MemoryImage(
                                                              base64Decode(
                                                                  equipmentProvider
                                                                      .items[i]
                                                                      .image))
                                                          // image: FileImage(
                                                          //     equipmentProvider
                                                          //         .items[i].image),
                                                          ),
                                                    ),
                                                  ),
                                                  Center(
                                                      child: Text(
                                                    equipmentProvider
                                                        .items[i].name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        fontFamily: 'Avenir'),
                                                  )),
                                                  Center(
                                                      child: Text(
                                                        'initial quantity: ' +
                                                    equipmentProvider
                                                            .items[i].quantity
                                                        ,
                                                    style: TextStyle( 
                                                        fontSize: 15,
                                                        fontFamily: 'Avenir'),
                                                  )),
                                                  // Center(
                                                  //     child: Text(
                                                  //       'present quantity: ' +
                                                  //   equipmentProvider
                                                  //           .items[i].presentQuantity 
                                                  //       ,
                                                  //   style: TextStyle( 
                                                  //       fontSize: 15,
                                                  //       fontFamily: 'Avenir'),
                                                  // )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EquipmentSearch extends SearchDelegate<Equipment> {
  DBHelpers db = new DBHelpers();
  List<Equipment> items = [];
  List<Equipment> suggestion = [];
  EquipmentSearch(this.items);

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    final suggestion = query.isEmpty
        ? items
        : items
            .where((target) => target.name.toLowerCase().contains(query))
            .toList();
    if (items.isEmpty) {
      return Center(child: Text('Search for an equipment!'));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, position) => ListTile(
        title: InkWell(
            onTap: () {
              print(suggestion[position].id);
              Navigator.of(context).pushNamed(EquipmentDetailScreen.routeName,
                  arguments: suggestion[position].id);
            },
            child: Card(
                child:ListTile( title: Container(
                    margin: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * .03,
                    child: Text(
                      suggestion[position].name.toString(),
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ))))),
      ),
      itemCount: suggestion.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestion = query.isEmpty
        ? items
        : items
            .where((target) => target.name.toLowerCase().contains(query))
            .toList();
    if (items.isEmpty) {
      return Center(child: Text('Search for an equipment!'));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, position) => ListTile(
        title: Text(suggestion[position].name.toString()),
      ),
      itemCount: suggestion.length,
    );
  }
}
