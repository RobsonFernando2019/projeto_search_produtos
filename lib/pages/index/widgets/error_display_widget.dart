import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    required this.onTryAgain,
  });
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Infelizmente algum erro ocorreu :(',
            style: TextStyle(
              fontSize: 17,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Precione o botão "Tentar novamente" para recarregar',
            style: TextStyle(
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            onPressed: onTryAgain,
            child: Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}
