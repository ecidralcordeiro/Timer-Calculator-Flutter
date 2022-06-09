import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class TextFieldCustom extends StatelessWidget {
  final TextEditingController controler;
  String textLabel = '';
  String textPlaceHolder = '';
  bool visible = true;
  bool required = false;
  bool readOnly = false;
  ValueChanged<String>? onChanged;
  ValueChanged<String>? validator;
  GestureTapCallback? onTap;
  List<TextInputFormatter>? maskFormatter;

  TextFieldCustom(
      {required this.controler,
        required this.textLabel,
        required this.textPlaceHolder,
        required this.readOnly,
        required this.required,
        this.onChanged,
        this.validator,
        this.onTap,
        this.maskFormatter})
      : super(key: GlobalKey<FormState>());



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(children: <Widget>[
        Visibility(
          visible: visible,
          child: Tooltip(
            message: textPlaceHolder,
            child: TextFormField(
              textAlign: TextAlign.right,
              inputFormatters: maskFormatter,
              controller: controler,
              keyboardType: TextInputType.none,
              style: TextStyle(fontSize: 24,),


              // The validator receives the text that the user has entered.
              validator: (value) {
                if (required) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                }
              },

              // validator: (value) {
              //   if (validator != null) {
              //     validator!(value!);
              //   } else
              //   if (required) {
              //     if (value == "") {
              //       return 'Campo obrigatório';
              //     }
              //   }
              //   return null;
              // },
              //
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              onTap: onTap,
              readOnly: readOnly,
            ),
          ),
        ),
      ]),
    );
  }
}