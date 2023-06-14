/*
 * @Author: Cao Shixin
 * @Date: 2020-05-27 11:33:43
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2022-07-28 16:13:53
 * @Description:
 * @Email: cao_shixin@yahoo.com
 * @Company: BrainCo
 */
import 'package:flutter/material.dart';
import 'package:flutter_chart_csx/flutter_chart_csx.dart';
import 'package:flutter_rich_ex/util/export.dart';


class ChartCurvePage extends StatelessWidget {
  final List list;
  final int yMax;
  ChartCurvePage({Key? key,required this.list,required this.yMax}) : super(key: key);

  ChartBeanSystem? _chartLineBeanSystem;
  late List tempOriArr;
  late List<ChartLineBean> tempDatas;

  @override
  Widget build(BuildContext context) {
    tempOriArr = list;
    tempOriArr = tempOriArr.reversed.toList();
    tempDatas = <ChartLineBean>[];
    for (var i = 0; i < tempOriArr.length; i++) {
      tempDatas.add(
        ChartLineBean(
          y: tempOriArr[i]['price'].toDouble(),
          xPositionRetioy: (1 / (tempOriArr.length - 1)) * i,
          tag: '100',
        ),
      );
    }
    _chartLineBeanSystem = ChartBeanSystem(
      lineWidth: 2,
      isCurve: true,
      chartBeans: tempDatas,
      shaderColors: [
        const Color(0xff26C165).withOpacity(0.6),
        const Color(0xff26C165).withOpacity(0.3),
        const Color(0xff26C165).withOpacity(0.1),
      ],
      lineColor: const Color(0xff26C165),
    );
    return _buildChartCurve(context);
  }

  ///curve
  Widget _buildChartCurve(context) {
    var tempXs = <DialStyleX>[];
    for (var i = 0; i < tempOriArr.length; i++) {
      String xDay = '\n${tempOriArr[i]['daily']}';
      tempXs.add(
        DialStyleX(
            title: xDay,
            titleStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
            positionRetioy: (1 / (tempOriArr.length - 1)) * i),
      );
    }
    var yStyle = const TextStyle(fontSize: 10.0, color: Colors.black);
    var chartLine = ChartLine(
      xDialValues: tempXs,
      chartBeanSystems: [_chartLineBeanSystem!],
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 5 * 1.6),
      baseBean: BaseBean(
          xColor: Colors.white,
          yColor: Colors.white,
          yDialValues: [
            DialStyleY(
              title: '0',
              titleStyle: yStyle,
              positionRetioy: 0 / yMax,
            ),
            DialStyleY(
              title: (yMax ~/ 2).toString(),
              titleStyle: yStyle,
              positionRetioy: (yMax ~/ 2) / yMax,
            ),
            DialStyleY(
              title: '$yMax',
              titleStyle: yStyle,
              positionRetioy: yMax / yMax,
            )
          ],
          yMax: yMax.toDouble(),
          yMin: 0,
          isLeftYDial: false,
          isShowHintY: false,
          isHintLineImaginary: true,
          basePadding: const EdgeInsets.only(right: 20),
      ),
    );
    return Container(
      child: chartLine,
    );

    // return Card(
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    //   // margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    //   margin: EdgeInsets.all(0),
    //   semanticContainer: true,
    //   clipBehavior: Clip.antiAlias,
    //   // color: Colors.green.withOpacity(0.5),
    //   child: chartLine,
    // );
  }
}

// class ChartCurvePage extends StatefulWidget {
//   static const String routeName = 'chart_curve';
//   static const String title = '平滑曲线带填充颜色';
//   final List list;
//
//   @override
//   _ChartCurveState createState() => _ChartCurveState();
// }
//
// class _ChartCurveState extends State<ChartCurvePage> {
//   ChartBeanSystem? _chartLineBeanSystem;
//   List tempOriArr = [
//     {
//       "daily": "6.12",
//       "price": 50
//     },
//     {
//       "daily": "6.11",
//       "price": 2.3244
//     },
//     {
//       "daily": "6.10",
//       "price": 41.4645
//     },
//     {
//       "daily": "6.9",
//       "price": 30
//     },
//     {
//       "daily": "6.8",
//       "price": 20.4568
//     },
//     {
//       "daily": "6.7",
//       "price": 1.154
//     },
//     {
//       "daily": "6.6",
//       "price": 65.64
//     },
//     {
//       "daily": "6.5",
//       "price": 34.54
//     },
//     {
//       "daily": "6.4",
//       "price": 40
//     },
//     {
//       "daily": "6.3",
//       "price": 50
//     },
//     {
//       "daily": "6.2",
//       "price": 16
//     },
//     {
//       "daily": "6.1",
//       "price": 5
//     },
//     {
//       "daily": "5.31",
//       "price": 15
//     },
//     {
//       "daily": "5.30",
//       "price": 20
//     },
//     {
//       "daily": "5.29",
//       "price": 3
//     }
//   ];
//
//   @override
//   void initState() {
//     var dataarr = [30.0, 88.0, 90.0, 91.0, 80.0, 84.0, 70.0,71.0,72.0,73.0,74.0,76.0,77.0,78.0,79.0,90.0];
//     var tempDatas = <ChartLineBean>[];
//
//     // for (var i = 0; i < dataarr.length; i++) {
//     //   tempDatas.add(
//     //     ChartLineBean(
//     //         y: dataarr[i],
//     //         xPositionRetioy: (1 / (dataarr.length - 1)) * i,
//     //         tag: '100'
//     //     ),
//     //   );
//     // }
//     tempOriArr = tempOriArr.reversed.toList();
//     for (var i = 0; i < tempOriArr.length; i++) {
//       tempDatas.add(
//         ChartLineBean(
//             y: tempOriArr[i]['price'].toDouble(),
//             xPositionRetioy: (1 / (tempOriArr.length - 1)) * i,
//             tag: '100',
//         ),
//       );
//     }
//     _chartLineBeanSystem = ChartBeanSystem(
//       lineWidth: 2,
//       isCurve: true,
//       chartBeans: tempDatas,
//       shaderColors: [
//         const Color(0xff26C165).withOpacity(0.6),
//         const Color(0xff26C165).withOpacity(0.3),
//         const Color(0xff26C165).withOpacity(0.1),
//       ],
//       lineColor: const Color(0xff26C165),
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildChartCurve(context);
//   }
//
//   ///curve
//   Widget _buildChartCurve(context) {
//     var tempXs = <DialStyleX>[];
//     for (var i = 0; i < tempOriArr.length; i++) {
//       String xDay = '${tempOriArr[i]['daily']}';
//       tempXs.add(
//         DialStyleX(
//             title: xDay,
//             titleStyle: TextStyle(color: Colors.grey[600], fontSize: 10),
//             positionRetioy: (1 / (tempOriArr.length - 1)) * i),
//       );
//     }
//     var chartLine = ChartLine(
//       xDialValues: tempXs,
//       chartBeanSystems: [_chartLineBeanSystem!],
//       size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 5 * 1.6),
//       baseBean: BaseBean(
//         xColor: Colors.white,
//         yColor: Colors.white,
//         yDialValues: [
//           DialStyleY(
//             title: '0',
//             titleStyle: TextStyle(fontSize: 10.0, color: Colors.black),
//             positionRetioy: 0 / 100.0,
//           ),
//           DialStyleY(
//             title: '35',
//             titleStyle: TextStyle(fontSize: 10.0, color: Colors.black),
//             positionRetioy: 35 / 100.0,
//           ),
//           DialStyleY(
//             title: '65',
//             titleStyle: TextStyle(fontSize: 10.0, color: Colors.black),
//             positionRetioy: 65 / 100.0,
//           ),
//           DialStyleY(
//             title: '100',
//             titleStyle: TextStyle(fontSize: 10.0, color: Colors.black),
//             positionRetioy: 100 / 100.0,
//           )
//         ],
//         yMax: 100,
//         isLeftYDial: false,
//         isShowHintY: false,
//         isHintLineImaginary: true,
//         basePadding: const EdgeInsets.only(right: 20)
//       ),
//     );
//     return Container(
//       child: chartLine,
//     );
//     // return Card(
//     //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     //   // margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
//     //   margin: EdgeInsets.all(0),
//     //   semanticContainer: true,
//     //   clipBehavior: Clip.antiAlias,
//     //   // color: Colors.green.withOpacity(0.5),
//     //   child: chartLine,
//     // );
//   }
// }