import 'package:flutter/material.dart';

class DashBoardRowWidget extends StatelessWidget {
  final String? firstTitle;
  final String? firstValue;
  final String? secoundTitle;
  final String? secoundValue;

  DashBoardRowWidget({
    this.firstTitle,
    this.firstValue,
    this.secoundValue,
    this.secoundTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Card(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Text(
                    firstValue!,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(firstTitle!),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Text(
                    secoundValue!,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(secoundTitle!),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
