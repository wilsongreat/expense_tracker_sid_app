import 'package:expense_tracker_sid_app/feature/graph/bar_entity.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData(
      {required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount});

  List<BarEntity> barData = [];

  void initBarData(){
    barData = [
      BarEntity(x: 0, y: sunAmount),
      BarEntity(x: 1, y: monAmount),
      BarEntity(x: 2, y: tueAmount),
      BarEntity(x: 3, y: wedAmount),
      BarEntity(x: 4, y: thurAmount),
      BarEntity(x: 5, y: friAmount),
      BarEntity(x: 6, y: satAmount),
    ];
  }

}
