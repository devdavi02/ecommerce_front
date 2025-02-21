import 'package:flutter/material.dart';

class QuestionDialog extends StatefulWidget {
  final Function(String) onSubmit;

  const QuestionDialog({required this.onSubmit, Key? key}) : super(key: key);

  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  final TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Fazer uma Pergunta"),
      content: TextField(
        controller: questionController,
        decoration: InputDecoration(
          labelText: "Digite sua pergunta",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (questionController.text.isNotEmpty) {
              widget.onSubmit(questionController.text);
              Navigator.pop(context);
            }
          },
          child: Text("Enviar"),
        ),
      ],
    );
  }
}
