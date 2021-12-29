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
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Título',
                    floatingLabelStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  onSubmitted: (_) => _submitform(),
                  cursorColor: Theme.of(context).colorScheme.primary,
                ),
                TextField(
                  controller: _valueController,
                  decoration: InputDecoration(
                    labelText: 'Valor (R\$)',
                    floatingLabelStyle:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitform(),
                  cursorColor: Theme.of(context).colorScheme.primary,
                ),
                Row(
                  children: [
                    Text(
                      _selectedDate.toString() == ''
                          ? 'Nenhuma data selecionada'
                          : DateFormat('d/M/y').format(_selectedDate),
                    ),
                    Container(
                        margin: EdgeInsets.all(5),
                        child: ElevatedButton(
                          onPressed: _showDatePicker,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                ),
                              ),
                              Text('Selecione uma data')
                            ],
                          ),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _submitform,
                      child: const Text('Nova transação'),
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        primary: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
