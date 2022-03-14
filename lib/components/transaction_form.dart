import 'package:despesas_pessoais/components/adaptative_button.dart';
import 'package:despesas_pessoais/components/adaptative_date_picker.dart';
import 'package:despesas_pessoais/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;
  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

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
            AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChange: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                }),
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
