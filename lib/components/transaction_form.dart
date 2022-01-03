import 'package:despesas_pessoais/components/adaptative_button.dart';
import 'package:despesas_pessoais/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitform() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;
    final date = _selectedDate;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, date);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        _selectedDate = pickedDate ?? DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            AdaptativeTextField(
                label: 'Título',
                onSubmitted: _submitform,
                controller: _titleController,
                inputType: TextInputType.text),
            AdaptativeTextField(
              controller: _valueController,
              inputType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: _submitform,
              label: 'Valor R\$',
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                        'Data selecionada: ${DateFormat('d/M/y').format(_selectedDate)}')),
                Container(
                  margin: EdgeInsets.all(5),
                  child: ElevatedButton(
                    onPressed: _showDatePicker,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(4),
                          child: const Icon(
                            Icons.calendar_today_outlined,
                            size: 18,
                          ),
                        ),
                        Text('Selecione uma data')
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AdaptativeButton(
                    label: 'Nova transação', onPressed: _submitform),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
