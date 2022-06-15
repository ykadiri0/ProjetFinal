import 'package:flutterapp/position.dart';
import 'package:flutterapp/voituretracer.dart';

import 'tracer.dart';
import 'voiture.dart';
import 'package:flutter/material.dart';

class MakeDashboardItems extends StatefulWidget {
  const MakeDashboardItems({Key? key}) : super(key: key);

  @override
  _MakeDashboardItemsState createState() => _MakeDashboardItemsState();
}

class _MakeDashboardItemsState extends State<MakeDashboardItems> {
  Card makeDashboardItem(String title, String img, int index) {
    return Card(

      elevation: 2,
      margin: const EdgeInsets.all(8),

      child: Container(

        decoration: index == 0 || index == 3 || index == 4
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Color(0xFF1565C0),
                    Color(0x00000000),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(3.0, -1.0),
                  colors: [
                    Color(0xFFBBDEFB),
                    Color(0xFFFFFFFF),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  )
                ],
              ),
        child: InkWell(
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAppPosition()),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAppvt()),
              );
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAppv()),
              );
            }
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAppp()),
              );
            }
            if (index == 4) {
              //5.item
            }
            if (index == 5) {
              //6.item
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Image.asset(
                  img,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color.fromARGB(255, 170, 193, 232),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Picsart_22-06-09_13-45-27-423.png"),
            fit: BoxFit.cover,
          ),
        ),
      child:Column(
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Car-Finder",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(2),
              children: [
                makeDashboardItem("Location", "assets/map.png", 0),
                makeDashboardItem("Tracer->Voiture", "assets/calendar.png", 1),
                makeDashboardItem("Voiture", "assets/festival.png", 2),
                makeDashboardItem("Tracer", "assets/food.png", 3),


              ],
            ),
          ),
        ],
      ),),
    );
  }
}
