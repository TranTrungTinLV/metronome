import 'package:flutter/material.dart';

class IndactorRow extends StatelessWidget {
  final int step;
  final int stepLength;

  IndactorRow(this.step, this.stepLength);
  @override
  Widget build(BuildContext context) {
    final List steps = List.filled(stepLength, null);
    if (stepLength < 5) {
      return Container(
        margin: EdgeInsets.only(top: 0, bottom: 3),
        color: Colors.black,
        height: 360,
        width: 390,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: steps
                .asMap()
                .entries
                .map((entry) => Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 24, right: 24),
                    width: entry.key == 0 ? 40.0 : 40.0,
                    height: entry.key == 0 ? 40.0 : 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: step > -1 && (step % steps.length) == entry.key
                            ? Colors.orange
                            : Colors.orange[200])))
                .toList()),
      );
    }
    return Container(
      color: Colors.black,
      height: 390,
      width: 370,
      child: GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: steps.length > 4 ? steps.length : 4,
              mainAxisSpacing: 0.0,
              childAspectRatio: 2.0),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: index == 0 ? 40.0 : 40.0,
              height: index == 0 ? 40.0 : 40.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: step > -1 && (step % steps.length) == index
                      ? Colors.orange
                      : Colors.grey[300]),
            );
          }),
    );
  }
}
