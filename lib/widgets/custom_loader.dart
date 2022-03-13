import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF101010),
      child: Center(
        child: Image.asset('assets/images/loading.gif')
      )
    );
  }
}
