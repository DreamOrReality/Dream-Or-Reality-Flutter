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
              showTitle: false,
            ),
            PieChartSectionData(
              color: Colors.green,
              value: 10,
              title: 'Node.js',
              showTitle: false,
            ),
            PieChartSectionData(
              color: Colors.orange,
              value: 15,
              title: 'Django',
              showTitle: false,
            ),
            PieChartSectionData(
              color: Colors.red,
              value: 5,
              title: 'MySQL',
              showTitle: false,
            ),
            PieChartSectionData(
              color: Colors.purple,
              value: 20,
              title: 'SQLite',
              showTitle: false,
            ),
          ],
        ),
      ),
    );
  }
}
