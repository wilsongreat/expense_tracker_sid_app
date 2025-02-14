import 'package:expense_tracker_sid_app/feature/graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final double maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  const BarGraph(
      {super.key,
      required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thurAmount: thurAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    myBarData.initBarData();
    return BarChart(BarChartData(
        maxY: 100,
        minY: 0,
      gridData: FlGridData(show: false ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        show: true,
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: bottomTitles)),
      ),
      barGroups: myBarData.barData.map((data) => BarChartGroupData(x: data.x,barRods: [
        BarChartRodData(
            toY: data.y,
          color: Colors.green[800],
          width: 25,
          borderRadius: BorderRadius.circular(2),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxY,
            color: Colors.green[200]
          )
        ),
      ],),).toList()
    ));

  }

  Widget bottomTitles(double val, TitleMeta meta){
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14
    );

    Widget text;
    switch(val.toInt()){
      case 0:
        text = const Text('S', style: style,);
        break;
      case 1:
        text = const Text('M', style: style,);
        break;
      case 2:
        text = const Text('T', style: style,);
        break;
      case 3:
        text = const Text('W', style: style,);
        break;
      case 4:
        text = const Text('T', style: style,);
        break;
      case 5:
        text = const Text('F', style: style,);
        break;
      case 6:
        text = const Text('S', style: style,);
        break;
      default:
        text = const Text('', style: style,);
        break;
    }

    return SideTitleWidget(meta: TitleMeta(
      min: 0,
      max: 100,
      parentAxisSize: 300,
      axisPosition: 0.0, // Adjust this based on your fl_chart version
      appliedInterval: 10,
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40,
      ),
      formattedValue: '',
      axisSide: AxisSide.left,
      rotationQuarterTurns: 0,
    ),
    child: text, );
  }
}
