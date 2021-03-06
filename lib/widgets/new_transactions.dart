import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTx;

  NewTransaction(this.addNewTx) {
    //print("Consctructor NewTransaction Widget");
  }

  @override
  State<NewTransaction> createState() {
    //print("createState NewTransaction Widget");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    //print("Consctructor _NewTransaction State");
  }

  @override
  void initState() {
    //print("initState()");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    //print("didUpdateWidget()");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //print("dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).viewInsets.toString());
    return SingleChildScrollView(
      child: Card(
        // Adding new transaction widget
        elevation: 8,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleController,
                onSubmitted: (_) =>
                    _submitData(), // occurs when "Enter" is tapped
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Data Chosen!"
                            : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                      ),
                    ),
                    AdaptiveFlatButton(
                        text: "Choose date", handler: _presentDatePicker)
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text("Add Transaction"),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addNewTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }
}
