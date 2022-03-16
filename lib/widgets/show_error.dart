import 'package:flutter/material.dart';
import 'package:rick_and_morty_wiki_app/theme/theme_app.dart';

class ShowError extends StatefulWidget{
  const ShowError({
    Key? key,
    required this.message,
    required this.onPressed
  }) : super(key: key);

  final String message;
  final VoidCallback onPressed;

  @override
  _ShowError createState() => _ShowError();
}

class _ShowError extends State<ShowError> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFFFFFFF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/evil_morty.jpeg'),
          const SizedBox(height: 10),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22
            )
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: (){
              setState(() {
                childButton = const CircularProgressIndicator(color: ThemeApp.primaryColor);
              });
              widget.onPressed();
            },
            child: childButton,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              padding: const EdgeInsets.all(10),
              primary: ThemeApp.secondaryColor,
              onPrimary: ThemeApp.primaryColor,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w900
              )
            )
          )
        ]
      )
    );
  }

  Widget childButton = const Text('Vuelve a intentarlo');
}
