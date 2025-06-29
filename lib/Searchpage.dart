import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as Rive;
import 'gps.dart';
class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final List<String> buttonNames = [
    'Rover Location',
    'Plant Location',
    'Field View',
  ];

  final List<Icon> iconList = const [
    Icon(Icons.my_location, size: 40, color: Colors.brown),
    Icon(Icons.location_on, size: 40, color: Colors.brown),
    Icon(Icons.terrain, size: 40, color: Colors.brown),
    Icon(Icons.local_florist, size: 40, color: Colors.brown),
  ];

  final List<Widget?> routesList = const [
    null, // Rover Location Page
    null, // Plant Location Page
    null, // Field View Page
    null, // Plant View Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.brown[100],
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: buttonNames.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final label = buttonNames[index];
                final icon = iconList[index];
                final targetPage = routesList[index];

                return GestureDetector(
                  onTap: () {
                    print('Tapped on $label');
                    if (targetPage != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => targetPage),
                      );
                    }
                  },
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon,
                        const SizedBox(height: 10),
                        Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 305,
            left: 210,
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleMapPage(lat: 37.7749, lon: -122.4194),
                  ),
                );
              },
              child: SizedBox(
                width: 170,
                height: 170,
                child: Card(
                  color: Colors.brown[900],
                  child: Rive.RiveAnimation.asset("assets/location_icon.riv",fit: BoxFit.cover,),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
