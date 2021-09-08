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
      VxBox()
          .gray400
          .roundedLg
          .make()
          .h1(context)
          .w15(context)
          .pOnly(bottom: 8),
      TextField(
        decoration:
            InputDecoration(labelText: 'Title', border: InputBorder.none),
        controller: _titleController,
      ).pOnly(left: 25).box.gray200.roundedSM.make().p8(),
      TextField(
        decoration: InputDecoration(
            labelText: 'Write something on which you spent(just one line)',
            border: InputBorder.none),
        controller: _descController,
      ).pOnly(left: 25).box.gray200.roundedSM.make().p8(),
      TextField(
        decoration:
            InputDecoration(labelText: 'Amount', border: InputBorder.none),
        controller: _amountController,
        keyboardType: TextInputType.number,
      ).pOnly(left: 25).box.gray200.roundedSM.make().p8(),
      Container(
          height: 80,
          child: [
            Text(_selectedDate == DateTime(0, 0, 0, 0)
                    ? 'No Date Chosen!'
                    : 'Picked Date : ${_selectedDate.day}-' +
                        '${_selectedDate.month}-' +
                        '${_selectedDate.year}')
                .p12()
                .box
                .gray200
                .roundedSM
                .make()
                .pOnly(left: 10),
            WidthBox(MediaQuery.of(context).size.width * 0.3),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: _presentDatePicker,
              child: Text(
                'Choose Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ].hStack(alignment: MainAxisAlignment.spaceBetween)),
      'Add Transaction'
          .text
          .makeCentered()
          .p12()
          .box
          .linearGradient([Vx.teal300, Vx.blue300])
          .roundedLg
          .make()
          .w48(context)
          .h(MediaQuery.of(context).size.height * 0.07),
    ].vStack().p12().box.make().h56(context).wFull(context).scrollVertical();
  }
}
