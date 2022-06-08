import 'package:flutter/material.dart';

class WriteReview extends StatelessWidget {
  const WriteReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          elevation: 0,
          title: const Text(
            'Escribir Review',
            style: TextStyle(
              fontFamily: 'Titilium',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
