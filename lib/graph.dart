import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SensorGraphsPage extends StatelessWidget {
  final List<Map<String, dynamic>> sensorData = [
    {
      "Soil_pH": 6.5,
      "Light": 450,
      "Soil_Moisture": 60,
      "Temperature": 25,
      "Humidity": 55,
      "N": 80,
      "P": 40,
      "K": 60,
    },
    {
      "Soil_pH": 6.3,
      "Light": 470,
      "Soil_Moisture": 62,
      "Temperature": 26,
      "Humidity": 57,
      "N": 85,
      "P": 38,
      "K": 58,
    },
    {
      "Soil_pH": 6.6,
      "Light": 480,
      "Soil_Moisture": 64,
      "Temperature": 27,
      "Humidity": 58,
      "N": 90,
      "P": 42,
      "K": 65,
    },
    {
      "Soil_pH": 6.7,
      "Light": 490,
      "Soil_Moisture": 63,
      "Temperature": 25,
      "Humidity": 54,
      "N": 82,
      "P": 39,
      "K": 62,
    },
    {
      "Soil_pH": 6.4,
      "Light": 460,
      "Soil_Moisture": 61,
      "Temperature": 24,
      "Humidity": 56,
      "N": 87,
      "P": 41,
      "K": 63,
    },
  ];

  // Reuse analysis methods from your original code...
  String identifyTrend(List<double> values) {
    if (values.last > values.first) return 'increased';
    if (values.last < values.first) return 'decreased';
    return 'remained stable';
  }

  String describeAvg(String key, String unit) {
    final values = sensorData
        .map((e) => double.tryParse(e[key].toString()) ?? 0.0)
        .toList();
    final avg = values.reduce((a, b) => a + b) / values.length;
    return 'Average $key is ${avg.toStringAsFixed(1)}$unit.';
  }

  String analyzeTrend(String key) {
    final values = sensorData
        .map((e) => double.tryParse(e[key].toString()) ?? 0.0)
        .toList();
    final trend = identifyTrend(values);
    return '$key has $trend over time.';
  }

  @override
  Widget build(BuildContext context) {
    List<GraphWidget> charts = [
      GraphWidget(
        title: 'Soil pH',
        icon: FontAwesomeIcons.flask,
        data: _buildData('Soil_pH'),
        description: describeAvg('Soil_pH', ''),
        analysis: analyzeTrend('Soil_pH'),
      ),
      GraphWidget(
        title: 'Light Intensity',
        icon: FontAwesomeIcons.solidSun,
        data: _buildData('Light'),
        description: describeAvg('Light', ' lux'),
        analysis: analyzeTrend('Light'),
      ),
      GraphWidget(
        title: 'Soil Moisture',
        icon: FontAwesomeIcons.water,
        data: _buildData('Soil_Moisture'),
        description: describeAvg('Soil_Moisture', '%'),
        analysis: analyzeTrend('Soil_Moisture'),
      ),
      GraphWidget(
        title: 'Nitrogen (N)',
        icon: FontAwesomeIcons.leaf,
        data: _buildData('N'),
        description: describeAvg('N', ' mg/kg'),
        analysis: analyzeTrend('N'),
      ),
      GraphWidget(
        title: 'Phosphorus (P)',
        icon: FontAwesomeIcons.seedling,
        data: _buildData('P'),
        description: describeAvg('P', ' mg/kg'),
        analysis: analyzeTrend('P'),
      ),
      GraphWidget(
        title: 'Potassium (K)',
        icon: FontAwesomeIcons.pooStorm,
        data: _buildData('K'),
        description: describeAvg('K', ' mg/kg'),
        analysis: analyzeTrend('K'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Graphs', style: TextStyle(fontFamily: 'Raleway')),
        backgroundColor: Colors.green[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.brown[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(children: charts),
      ),
    );
  }

  List<DataPoint> _buildData(String key) {
    return sensorData
        .asMap()
        .entries
        .map((e) => DataPoint(
      x: e.key.toDouble(),
      y: double.tryParse(e.value[key].toString()) ?? 0.0,
    ))
        .toList();
  }
}

class DataPoint {
  final double x;
  final double y;
  const DataPoint({required this.x, required this.y});
}

class GraphWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<DataPoint> data;
  final String description;
  final String analysis;

  const GraphWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
    required this.description,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green[700], size: 28),
                const SizedBox(width: 8),
                Text(title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        color: Colors.green[800])),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                  title: AxisTitle(text: 'Time'),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Value'),
                ),
                series: <LineSeries<DataPoint, double>>[
                  LineSeries<DataPoint, double>(
                    dataSource: data,
                    xValueMapper: (DataPoint dp, _) => dp.x,
                    yValueMapper: (DataPoint dp, _) => dp.y,
                    color: Colors.green,
                    width: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text('Description:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                    color: Colors.green[800])),
            Text(description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Text('Analysis:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                    color: Colors.green[800])),
            Text(analysis, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
