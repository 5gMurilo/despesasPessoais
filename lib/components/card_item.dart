import 'dart:math';

import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardItem extends StatefulWidget {
  final Transaction transac;
  final void Function(String) onRemove;

  const CardItem({
    required this.transac,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  final colors = [
    Colors.black,
    Colors.blue.shade800,
    Colors.green.shade500,
    Colors.red.shade700
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();

    if (widget.transac.value <= 100) {
      _backgroundColor = colors[2];
    } else if (widget.transac.value <= 200) {
      _backgroundColor = colors[1];
    } else if (widget.transac.value <= 300) {
      _backgroundColor = colors[3];
    } else {
      _backgroundColor = colors[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return (Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: _backgroundColor,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: Padding(
            padding: const EdgeInsets.all(6.2),
            child: FittedBox(
              child: Text('R\$${widget.transac.value}'),
            ),
          ),
        ),
        title: Text(
          widget.transac.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat('d MMM y').format(widget.transac.date)),
        trailing: mediaQuery.size.width > 400
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.transac.id),
                icon: Icon(
                  Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error,
                ),
                label: Text(
                  'Excluir transação',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete_forever),
                onPressed: () {
                  widget.onRemove(widget.transac.id);
                },
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    ));
  }
}
