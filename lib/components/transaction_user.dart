import 'dart:math';
import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'transaction_form.dart';
import 'transaction_list.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({Key? key}) : super(key: key);

  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
        id: '1',
        title: 'Chinelo da oakley',
        value: 90.00,
        date: DateTime.now()),
    Transaction(
        id: '2',
        title: 'Cartão de crédito nubank',
        value: 77.86,
        date: DateTime(2021, 12, 10))
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TransactionForm(_addTransaction),
      TransactionList(_transactions),
    ]);
  }
}
