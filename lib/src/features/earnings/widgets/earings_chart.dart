import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:waiters_wallet/src/constants/constants.dart';
import 'package:waiters_wallet/src/utils/color_extensions.dart';

class EarningsChart extends StatefulWidget {
  EarningsChart({
    super.key,
    this.chartLevel = 0,
    required this.weekdata,
    required this.monthdata,
  });

  final int chartLevel;
  final List<double> weekdata;
  final List<double> monthdata;

  List<Color> get availableColors => <Color>[
        skinColorConst.darken(40),
        skinColorConst.darken(50),
        skinColorConst.darken(30),
        skinColorConst.darken(60),
        skinColorConst.darken(20),
        skinColorConst.darken(60),
      ];

  final Color barBackgroundColor = Colors.black.withOpacity(0.6);
  final Color barColor = skinColorConst;
  final Color touchedBarColor = skyBlueColorConst;

  @override
  State<StatefulWidget> createState() => EarningsChartState();
}

class EarningsChartState extends State<EarningsChart> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => loadData());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  void loadData() async {
    isPlaying = true;
    refreshState();
    await Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isPlaying = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: BarChart(
                      isPlaying ? randomData() : mainBarData(),
                      swapAnimationDuration: animDuration,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(40))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> weekList() {
      return List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, widget.weekdata[0],
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, widget.weekdata[1],
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, widget.weekdata[2],
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, widget.weekdata[3],
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, widget.weekdata[4],
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, widget.weekdata[5],
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, widget.weekdata[6],
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });
    }

    List<BarChartGroupData> monthList() {
      return List.generate(12, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, widget.monthdata[0],
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, widget.monthdata[1],
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, widget.monthdata[2],
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, widget.monthdata[3],
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, widget.monthdata[4],
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, widget.monthdata[5],
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, widget.monthdata[6],
                isTouched: i == touchedIndex);
          case 7:
            return makeGroupData(7, widget.monthdata[7],
                isTouched: i == touchedIndex);
          case 8:
            return makeGroupData(8, widget.monthdata[8],
                isTouched: i == touchedIndex);
          case 9:
            return makeGroupData(9, widget.monthdata[9],
                isTouched: i == touchedIndex);
          case 10:
            return makeGroupData(10, widget.monthdata[10],
                isTouched: i == touchedIndex);
          case 11:
            return makeGroupData(11, widget.monthdata[11],
                isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });
    }

    switch (widget.chartLevel) {
      case 0:
        return weekList();
      case 1:
        return monthList();
      default:
        return [];
    }
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: widget.barBackgroundColor.darken(80).withOpacity(0.6),
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String toolTipString;
            switch (widget.chartLevel) {
              case 0:
                toolTipString = getWeekTipString(group.x);
                break;
              case 1:
                toolTipString = getMonthTipString(group.x);
                break;
              default:
                toolTipString = "";
            }

            final earnings = rod.toY - 1;
            return BarTooltipItem(
              '$toolTipString\n',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: "\$$earnings",
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: widget.chartLevel == 0 ? true : false,
            getTitlesWidget: (value, meta) {
              final total = showingGroups()[value.toInt()].barRods.first.toY;
              final totalInInt = total.toInt();
              if (touchedIndex == value.toInt()) {
                return Text("\$${totalInInt - 1}");
              }
              return Text("\$$totalInInt");
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: const FlGridData(show: false),
    );
  }

  String getMonthTipString(int x) {
    String titleString = "";
    switch (x) {
      case 0:
        titleString = 'January';
        break;
      case 1:
        titleString = 'February';
        break;
      case 2:
        titleString = 'March';
        break;
      case 3:
        titleString = 'April';
        break;
      case 4:
        titleString = 'May';
        break;
      case 5:
        titleString = 'June';
        break;
      case 6:
        titleString = 'July';
        break;
      case 7:
        titleString = 'August';
        break;
      case 8:
        titleString = 'September';
        break;
      case 9:
        titleString = 'October';
        break;
      case 10:
        titleString = 'November';
        break;
      case 11:
        titleString = 'December';
        break;
      default:
        throw Error();
    }
    return titleString;
  }

  String getWeekTipString(int x) {
    String titleString = "";
    switch (x) {
      case 0:
        titleString = 'Monday';
        break;
      case 1:
        titleString = 'Tuesday';
        break;
      case 2:
        titleString = 'Wednesday';
        break;
      case 3:
        titleString = 'Thursday';
        break;
      case 4:
        titleString = 'Friday';
        break;
      case 5:
        titleString = 'Saturday';
        break;
      case 6:
        titleString = 'Sunday';
        break;
      default:
        throw Error();
    }
    return titleString;
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (widget.chartLevel) {
      case 0:
        text = getWeekTitleString(value.toInt());
        break;
      case 1:
        text = getMonthTitleString(value.toInt());
        break;
      default:
        text = "";
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: Text(text, style: style),
    );
  }

  String getWeekTitleString(int x) {
    String titleString = "";
    switch (x) {
      case 0:
        titleString = 'M';
        break;
      case 1:
        titleString = 'T';
        break;
      case 2:
        titleString = 'W';
        break;
      case 3:
        titleString = 'T';
        break;
      case 4:
        titleString = 'F';
        break;
      case 5:
        titleString = 'S';
        break;
      case 6:
        titleString = 'S';
        break;
      default:
        throw Error();
    }
    return titleString;
  }

  String getMonthTitleString(int x) {
    String titleString = "";
    switch (x) {
      case 0:
        titleString = 'J';
        break;
      case 1:
        titleString = 'F';
        break;
      case 2:
        titleString = 'M';
        break;
      case 3:
        titleString = 'A';
        break;
      case 4:
        titleString = 'M';
        break;
      case 5:
        titleString = 'J';
        break;
      case 6:
        titleString = 'J';
        break;
      case 7:
        titleString = 'A';
        break;
      case 8:
        titleString = 'S';
        break;
      case 9:
        titleString = 'O';
        break;
      case 10:
        titleString = 'N';
        break;
      case 11:
        titleString = 'D';
        break;
      default:
        throw Error();
    }
    return titleString;
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(
              0,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 1:
            return makeGroupData(
              1,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 2:
            return makeGroupData(
              2,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 3:
            return makeGroupData(
              3,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 4:
            return makeGroupData(
              4,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 5:
            return makeGroupData(
              5,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          case 6:
            return makeGroupData(
              6,
              Random().nextInt(15).toDouble() + 6,
              barColor: widget.availableColors[
                  Random().nextInt(widget.availableColors.length)],
            );
          default:
            return throw Error();
        }
      }),
      gridData: const FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}
