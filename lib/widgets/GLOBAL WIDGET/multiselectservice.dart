// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MultiSelect extends StatefulWidget {
  final List<String> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];
  String service_Selected = '';
  String temp1 = '';
// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  submit() {
    for (int i = 0; i < _selectedItems.length; i++) {
      service_Selected = '$service_Selected${_selectedItems[i]} , ';
      temp1 = service_Selected.substring(0, service_Selected.length - 2);
    }
    Navigator.pop(context, temp1);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Service'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                    checkColor: Colors.white,
                    activeColor: Colors.orange.shade700,
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
