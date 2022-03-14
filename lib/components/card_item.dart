import 'package:despesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardItem extends StatelessWidget {
  final Transaction transac;
  final void Function(String) onRemove;

  const CardItem(this.transac, this.onRemove, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return (Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          child: Padding(
            padding: const EdgeInsets.all(6.2),
            child: FittedBox(
              child: Text('R\$${transac.value}'),
            ),
          ),
        ),
        title: Text(
          transac.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat('d MMM y').format(transac.date)),
        trailing: mediaQuery.size.width > 400
            ? TextButton.icon(
                onPressed: () => onRemove(transac.id),
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
                  onRemove(transac.id);
                },
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    ));
  }
}
