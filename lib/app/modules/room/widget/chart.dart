import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:vku_vote/app/core/utils/extensions.dart';
import 'package:vku_vote/app/core/values/colors.dart';
import 'package:vku_vote/app/data/models/candidate_model.dart';

class ElectionChart extends StatelessWidget {
  List<Candidate> candidates;
  ElectionChart({required this.candidates});

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      
    };

    candidates.forEach((element) { 
      dataMap[element.name] = element.numVotes.toDouble();
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: blackColor
        ),
        centerTitle: true,
        title: Text("Biểu đồ dữ liệu phòng",style: TextStyle(
            color: blackColor,
            fontSize: 17.0.sizeP,
            fontWeight: FontWeight.w600
          ),
          overflow: TextOverflow.ellipsis,
        )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 15.0.widthP,
            chartRadius: MediaQuery.of(context).size.width / 2.5,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 15.0.widthP,
            centerText: "Votes",
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: true,
              decimalPlaces: 0,
            ),
          )
        ],
      ),
    );
  }
}