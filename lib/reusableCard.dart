import 'package:flutter/material.dart';

class ReSableCard extends StatelessWidget {
  ReSableCard({@required this.cardChild});
  Widget? cardChild;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:cardChild,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
