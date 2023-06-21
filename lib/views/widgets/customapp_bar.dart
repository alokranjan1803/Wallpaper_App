import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String word1;
  final String word2;
  const CustomAppBar({super.key ,

    required this.word1,
    required this.word2});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(

            text: word1 ,
            style: const TextStyle(color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
            children:  [

              TextSpan(
                text: " $word2",
                style:   const TextStyle(color: Colors.orangeAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
            ]
        )


    );
  }
}