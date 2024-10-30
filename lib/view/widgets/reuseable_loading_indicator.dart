import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ReuseableLoadingIndicator extends StatelessWidget {
  const ReuseableLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("asset/animation/Animation - 1713509052475.json"),
    );
  }
}
