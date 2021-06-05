import 'dart:io';
import '../pickers/user_image_picker_group.dart';
import '../../colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EditGroup extends StatefulWidget {
  final Function(String chatName,File picked) addTx;

  EditGroup(this.addTx);

  @override
  _EditGroupState createState() => _EditGroupState();
}

class _EditGroupState extends State<EditGroup> {

  final chatName = TextEditingController();
  final amountController = TextEditingController();
  File _imagePicked;
  DateTime selectDate;

  void _submitData() {
    final enteredTitle = chatName.text;

    widget.addTx(
        chatName.text,_imagePicked);
    Navigator.of(context).pop();
  }



  void _pickedImage(File pickedImage){

    _imagePicked = pickedImage;

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
                  labelText: 'Chat Name',
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
              UserImagePickerGroup(_pickedImage),
              OutlinedButton.icon(
                onPressed: _submitData,
                icon: Icon(Icons.file_upload_outlined, size: 18, color: kPrimaryColor),
                label: Text("Update Chat",
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