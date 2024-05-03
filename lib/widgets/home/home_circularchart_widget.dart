import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CircularChart extends StatelessWidget {
  const CircularChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: [
            PieChartSectionData(
              color: Colors.blue,
              value: 50,
              title: 'Flutter',
              titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
              showTitle: true,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 10,
              title: 'Node.js',
              titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
              showTitle: true,
            ),
            PieChartSectionData(
              color: Colors.orange,
              value: 15,
              title: 'Django',
              titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
              showTitle: true,
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 5,
              title: 'MySQL',
              titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
              showTitle: true,
            ),
            PieChartSectionData(
              color: Colors.purple,
              value: 20,
              title: 'SQLite',
              titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
              showTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
