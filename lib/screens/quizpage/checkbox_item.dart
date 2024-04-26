import 'package:flutter/material.dart';

class CheckboxItem extends StatefulWidget {
  final String question;

  const CheckboxItem({super.key, required this.question});

  @override
  _CheckboxItemState createState() => _CheckboxItemState();
}

class _CheckboxItemState extends State<CheckboxItem> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.question),
      controlAffinity: ListTileControlAffinity.leading,
      value: _value,
      onChanged: (bool? value) {
        setState(() {
          _value = value!;
        });
      },
    );
  }
}
