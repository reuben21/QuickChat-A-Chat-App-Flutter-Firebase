import '../../colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AddChat extends StatefulWidget {
  final Function addTx;

  AddChat(this.addTx);

  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  final chatName = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectDate;

  void _submitData() {
    final enteredTitle = chatName.text;

    if (enteredTitle.isEmpty ) {
      return;
    }
    widget.addTx(
        chatName.text);
    Navigator.of(context).pop();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 1,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                controller: chatName,
                cursorColor: kPrimaryColor,
                maxLength: 20,
                onFieldSubmitted: (_) => _submitData(),
                decoration: InputDecoration(
                  labelText: 'Chat Id',
                  labelStyle: TextStyle(color: kPrimaryColor),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),

                  // helperText: 'Amount',
                  suffixIcon: Icon(
                    Icons.check_circle,
                    color: kPrimaryColor,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),

              OutlinedButton.icon(
                onPressed: _submitData,
                icon: Icon(Icons.add, size: 18, color: kPrimaryColor),
                label: Text("Enter Chat",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                    )),
              ),
            ]),
      ),
    );
  }
}