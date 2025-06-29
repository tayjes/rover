import 'package:flutter/material.dart';
import 'graph.dart';
class SensorDataPage extends StatelessWidget {
  // Simulated sensor data list – one per field section
  final List<Map<String, dynamic>> sensorDataList = [
    {
      'area': 'Field A',
      'temperature': 28.4,
      'humidity': 72,
      'npk': '12-32-16',
      'soilMoisture': 48,
    },
    {
      'area': 'Field B',
      'temperature': 31.1,
      'humidity': 65,
      'npk': '10-30-20',
      'soilMoisture': 55,
    },
    {
      'area': 'Field C',
      'temperature': 26.0,
      'humidity': 80,
      'npk': '15-15-15',
      'soilMoisture': 63,
    },
    {
      'area': 'Field D',
      'temperature': 26.0,
      'humidity': 80,
      'npk': '15-15-15',
      'soilMoisture': 63,
    },
    {
      'area': 'Field E',
      'temperature': 26.0,
      'humidity': 80,
      'npk': '15-15-15',
      'soilMoisture': 63,
    },
    {
      'area': 'Field F',
      'temperature': 26.0,
      'humidity': 80,
      'npk': '15-15-15',
      'soilMoisture': 63,
    },

    // Add more entries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            pinned: true,
            floating: false,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Sensor Overview',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
              background: Image.asset('assets/wood.png', fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final data = sensorDataList[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  color: Color(0xFFF9F5E3),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      data['area'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text('🌡 Temperature: ${data['temperature']} °C'),
                        Text('💧 Humidity: ${data['humidity']} %'),
                        Text('🌿 NPK Ratio: ${data['npk']}'),
                        Text('🪴 Soil Moisture: ${data['soilMoisture']} %'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        color: Colors.green[700],
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SensorGraphsPage()));
                      },
                    ),
                  ),
                ),
              );
            }, childCount: sensorDataList.length),
          ),
        ],
      ),
    );
  }
}
