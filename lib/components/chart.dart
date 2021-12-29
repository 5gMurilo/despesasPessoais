import 'package:despesas_pessoais/components/chart_bar.dart';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );

      double totalSum = 0;

      for (var transactions in recentTransactions) {
        bool sameDay = transactions.date.day == weekDay.day;
        bool sameMonth = transactions.date.month == weekDay.month;
        bool sameYear = transactions.date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += transactions.value;
        }
      }

      print(DateFormat.E().format(weekDay)[0]);
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalExpenses {
    return groupedTransactions.fold(0.0, (previousValue, element) {
      return previousValue + (element['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...groupedTransactions.map((tr) {
              return Expanded(
                child: ChartBar(
                    valorGasto: double.parse(tr['value'].toString()),
                    label: tr['day'].toString(),
                    percent: (tr['value'] as double) / _weekTotalExpenses),
              );
            })
          ],
        ),
      ),
    );
  }
}
