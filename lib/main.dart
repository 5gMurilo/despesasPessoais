import 'dart:math';
import 'dart:io';
import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';

void main(List<String> args) {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 82, 183, 136),
          onPrimary: Color.fromARGB(255, 255, 250, 246),
          secondary: Color.fromARGB(255, 64, 145, 108),
          onSecondary: Color.fromARGB(255, 234, 255, 220),
        ),
        fontFamily: 'Lato',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          toolbarTextStyle: ThemeData.light().textTheme.copyWith().bodyText1,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                ),
              )
              .headline6,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final String _appTitle = 'Despesas pessoais';

  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _openTansactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        isScrollControlled: true,
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                left: 7,
                right: 7,
              ),
              child: TransactionForm(_addTransaction),
            ),
          );
        });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  bool _showChart = false;

  Widget _getIconButton(IconData icon, VoidCallback fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(onPressed: fn, icon: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.chart_bar : Icons.bar_chart;

    final appBar = AppBar(
      centerTitle: true,
      title: Text(
        _appTitle,
        style: const TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.bold,
          letterSpacing: 0.18,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        _getIconButton(
          Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTansactionFormModal(context),
        ),
        if (isLandscape)
          _getIconButton(
            _showChart ? iconList : iconChart,
            () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          )
      ],
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.7 : 0.25),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    final actions = [
      IconButton(
        onPressed: () => _openTansactionFormModal(context),
        icon: const Icon(Icons.add),
      ),
      if (isLandscape)
        IconButton(
          onPressed: () {
            setState(() {
              _showChart = !_showChart;
            });
          },
          icon:
              _showChart ? const Icon(Icons.list) : const Icon(Icons.bar_chart),
        )
    ];

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(_appTitle),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (_showChart || !isLandscape)
                    SizedBox(
                      height: availableHeight * (isLandscape ? 0.7 : 0.25),
                      child: Chart(_recentTransactions),
                    ),
                  if (!_showChart || !isLandscape)
                    SizedBox(
                      height: availableHeight * (isLandscape ? 1 : 0.7),
                      child: TransactionList(_transactions, _removeTransaction),
                    ),
                ],
              ),
            ),
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _openTansactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
