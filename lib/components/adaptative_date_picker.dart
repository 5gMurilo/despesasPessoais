import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChange(pickedDate);
    });
  }

  const AdaptativeDatePicker(
      {Key? key, required this.selectedDate, required this.onDateChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: onDateChange,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2020),
              maximumDate: DateTime.now(),
            ))
        : SizedBox(
            child: Row(
            children: <Widget>[
              Expanded(
                  child: Text(
                      'Data selecionada: ${DateFormat('d/MM/y').format(selectedDate)}')),
              Container(
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () => _showDatePicker(context),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                        ),
                      ),
                      const Text('Selecione uma data')
                    ],
                  ),
                ),
              ),
            ],
          ));
  }
}
