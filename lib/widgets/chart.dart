import 'package:max/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              sections: showingSections(),
              startDegreeOffset: -90,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  "29.1",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      height: 0.5),
                ),
                Text("Of 128GB")
              ],
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(5, (i) {
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: primaryColor,
            value: 25,
            showTitle: false,
            radius: 25,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff26E5FF),
            value: 20,
            showTitle: false,
            radius: 22,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xffFFCF26),
            value: 10,
            showTitle: false,
            radius: 19,
          );
        case 3:
          return PieChartSectionData(
            showTitle: false,
            color: Color(0xFFEE2727),
            value: 15,
            radius: 16,
          );
        case 4:
          return PieChartSectionData(
            showTitle: false,
            color: primaryColor.withOpacity(0.1),
            value: 20,
            radius: 13,
          );
        default:
          return PieChartSectionData(
            showTitle: false,
            color: primaryColor.withOpacity(0.1),
            value: 20,
            radius: 13,
          );
      }
    });
  }
}
