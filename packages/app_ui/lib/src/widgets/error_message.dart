import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    this.errorMessage = 'Erro desconhecido',
    super.key,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline,
            size: 64, color: Theme.of(context).colorScheme.error),
        const SizedBox(height: 16),
        Text(
          errorMessage,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
