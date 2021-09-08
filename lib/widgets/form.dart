import 'package:expenses_tracker/helpers/db_helper.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/providers/expenses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class CollecingForm extends StatefulWidget {
  @override
  _CollecingFormState createState() => _CollecingFormState();
}

class _CollecingFormState extends State<CollecingForm> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _descController = TextEditingController();

  DateTime _selectedDate = DateTime(0, 0, 0, 0);

  Future<void> _dataSubmit(BuildContext ctx) async {
    if (_amountController.text == null) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    var exp = new Expense(
      title: enteredTitle,
      description: _descController.text,
      date: _selectedDate,
      amount: enteredAmount,
    );

    //  Provider.of<Expenses>(ctx, listen: false).addToExpensesList(exp);
    // if (enteredAmount > Provider.of<Expenses>(ctx, listen: false).maxLimit) {
    //   Provider.of<Expenses>(ctx, listen: false).updateLimit();
    // }
    await Provider.of<Expenses>(ctx, listen: false).addToExpensesList(exp);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return [
      TextField(
        decoration: InputDecoration(labelText: 'Title'),
        controller: _titleController,
      ),
      TextField(
        decoration: InputDecoration(
            labelText: 'Write something on which you spent(just one line)'),
        controller: _descController,
      ),
      TextField(
        decoration: InputDecoration(labelText: 'Amount'),
        controller: _amountController,
        keyboardType: TextInputType.number,
      ),
      Container(
        height: 80,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(_selectedDate == DateTime(0, 0, 0, 0)
                  ? 'No Date Chosen!'
                  : 'Picked Date : ${_selectedDate.day}-' +
                      '${_selectedDate.month}-' +
                      '${_selectedDate.year}'),
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: _presentDatePicker,
              child: Text(
                'Choose Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      RaisedButton(
        child: Text('Add Transaction'),
        onPressed: () => _dataSubmit(context),
        color: Theme.of(context).primaryColor,
      ),
    ].vStack().p12().box.make().h48(context).wFull(context).scrollVertical();
  }
}
