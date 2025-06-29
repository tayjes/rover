import 'package:flutter/material.dart';
import 'datacollection.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class PlantsPage extends StatelessWidget {
   final List<String> buttonNames = [
    'Data Collected',
    'View Results',
    'Pest Detail',
    'Footage',
  ];

   final List<Icon> iconList = [
    Icon(Icons.data_thresholding_outlined, size: 40, color: Colors.brown),
    Icon(Icons.dashboard, size: 40, color: Colors.brown),
    Icon(FontAwesomeIcons.sunPlantWilt, size: 40, color: Colors.brown),
    Icon(Icons.video_camera_back_outlined, size: 40, color: Colors.brown),
  ];

  final List<Widget?> routesList = [
    SensorDataPage(),
    null,
    null,
    null,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFA7D7C5), Color(0xFFEDF2D0)], // green to beige
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 6,
                    shadowColor: Colors.brown.withOpacity(0.5),
                    color: const Color(0xFFF9F5E3),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/img.png'),
                          fit: BoxFit.cover,
                          opacity: 0.5,
                        ),
                      ),
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
                          const SizedBox(height: 6),
                          Icon(Icons.eco, color: Colors.green[700], size: 18),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
