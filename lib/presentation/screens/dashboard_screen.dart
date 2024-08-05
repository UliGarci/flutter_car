import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.lightBlueAccent.shade400,
            unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
            selectedIconTheme: IconThemeData(color: Colors.black),
            extended: isExpanded,
            destinations: [
              NavigationRailDestination(
                  icon: Icon(Icons.home), label: Text('Get')),
              NavigationRailDestination(
                  icon: Icon(Icons.add), label: Text('Add')),
              NavigationRailDestination(
                  icon: Icon(Icons.update), label: Text('Update')),
              NavigationRailDestination(
                  icon: Icon(Icons.delete), label: Text('Delete')),
            ],
            selectedIndex: 0,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(60.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            icon: Icon(Icons.menu),
                          ),
                        ]),
                        SizedBox(height: 20.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Card(
                                
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        Icon(Icons.article,size: 26.0,),
                                        SizedBox(width: 15.0,),
                                        Text("Articulos",style: (TextStyle(fontSize: 26.0,fontWeight: FontWeight.bold)),)
                                      ],
                                    ),
                                  ),
                              
                              ),
                            )
                          ],
                          )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
