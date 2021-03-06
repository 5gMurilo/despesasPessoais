import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double valorGasto;
  final String label;
  final double percent;

  const ChartBar({
    this.valorGasto = 0,
    this.label = '',
    this.percent = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    print('build() chartbar');
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text('${valorGasto.toStringAsFixed(2)}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.04,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percent,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.04,
            ),
            Text(label)
          ],
        );
      },
    );
  }
}
