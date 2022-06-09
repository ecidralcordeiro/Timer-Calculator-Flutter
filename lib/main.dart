
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:time_calculator/text_field_custom.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    ));

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  var controller = TextEditingController();
  String appearsScreen = "";
  String typedButton = "";
  String num1 = "";
  String num2 = "";
  String operand = "";
  String showView = "";
  late int number1;
  late int number2;

  Widget buildButton(String ButtonVal) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(2.0, 2.0), blurRadius: 8.0, spreadRadius: 1.0),
          BoxShadow(color: Colors.white, offset: Offset(-2.0, -2.0), blurRadius: 8.0, spreadRadius: 1.0),
        ],
      ),
      child: MaterialButton(
        padding: EdgeInsets.all(30.0),
        child: Text(
          ButtonVal,
          style: TextStyle(fontSize: 22.0),
        ),
        onPressed: () => buttonPressed(ButtonVal),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    alignment: Alignment.centerRight,
                    child: TextFieldCustom(
                      controler: controller,
                      maskFormatter: [getHorasMask()],
                      textLabel: '###.##',
                      textPlaceHolder: '',
                      required: true,
                      readOnly: false,
                      onChanged: (test) {
                        print(controller.text);
                      },
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.white.withOpacity(0.2),
                    margin: EdgeInsets.all(16),
                    child: Text(
                      showView,
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    )),
                Expanded(
                  child: Divider(),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[buildButton("7"), buildButton("8"), buildButton("9"), buildButton("C")],
                    ),
                    Row(
                      children: <Widget>[buildButton("4"), buildButton("5"), buildButton("6"), buildButton("+")],
                    ),
                    Row(
                      children: <Widget>[buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")],
                    ),
                    Row(
                      children: <Widget>[
                        buildButton("0"),
                        buildButton("="),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  buttonPressed(String btnVal) {
    appearsScreen = controller.text;

    if (btnVal == "C") {
      showView = "";
      typedButton = "";
      num1 = "";
      num2 = "";
      operand = "";
      controller.text = "00:00";
    } else if (btnVal == "+" || btnVal == "-" || btnVal == "*" || btnVal == "/") {
      num1 = appearsScreen;
      operand = btnVal;
      typedButton = "";
      appearsScreen = appearsScreen + btnVal;
    } else if (btnVal == "=") {
      num2 = appearsScreen;
      if (num1.length == 4) {
        num1 = "0" + num1.substring(0, 2) + ":" + num1.substring(2);
      } else if (num1.length == 3) {
        num1 = "00" + num1.substring(0, 1) + ":" + num1.substring(1);
      } else if (num1.length == 2) {
        num1 = "000:" + num1;
      } else if (num1.length == 1) {
        num1 = "000:0" + num1;
      }

      if (num2.length == 4) {
        num2 = "0" + num2.substring(0, 2) + ":" + num2.substring(2);
      } else if (num2.length == 3) {
        num2 = "00" + num2.substring(0, 1) + ":" + num2.substring(1);
        print("alo");
        print(num2);
      } else if (num2.length == 2) {
        num2 = "000:" + num2;
      } else if (num2.length == 1) {
        num2 = "000:0" + num2;
      }

      if (operand == "+") {
        var sub1 = int.parse(num1.substring(0, 3));
        var sub2 = int.parse(num1.substring(4));
        sub1 = sub1 * 60;

        number1 = sub1 + sub2;

        sub1 = int.parse(num2.substring(0, 3));
        sub2 = int.parse(num2.substring(4));
        sub1 = sub1 * 60;
        number2 = sub1 + sub2;

        int soma = number1 + number2;
        double horas = soma / 60;

        String strHoras = horas.toStringAsFixed(2);
        strHoras = strHoras.substring(0, strHoras.length - 3);
        double minutos = soma % 60;

        String strMinutos = minutos.toString();

        if (strHoras.length == 1) {
          strHoras = "0" + strHoras;
        }
        if (strMinutos.length == 2) {
        } else if (strMinutos.length == 1) {
          strMinutos = "0" + strMinutos;
        } else {
          strMinutos = "00" + strMinutos;
        }

        strHoras = strHoras.replaceAll(".", "");

        showView = "$strHoras" + ":" + "$strMinutos";

        typedButton = (num2 + num1);
        controller.text = typedButton;
      }
      if (operand == "-") {
        var sub1 = int.parse(num1.substring(0, 3));
        var sub2 = int.parse(num1.substring(4));
        sub1 = sub1 * 60;

        number1 = sub1 + sub2;

        sub1 = int.parse(num2.substring(0, 3));
        sub2 = int.parse(num2.substring(4));
        sub1 = sub1 * 60;
        number2 = sub1 + sub2;

        int subtracao = number1 - number2;
        double horas = subtracao / 60;

        String strHoras = horas.toStringAsFixed(2);
        strHoras = strHoras.substring(0, strHoras.length - 3);
        double minutos = subtracao % 60;

        String strMinutos = minutos.toString();

        if (strHoras.length == 1) {
          strHoras = "0" + strHoras;
        }
        if (strMinutos.length == 2) {
        } else if (strMinutos.length == 1) {
          strMinutos = "0" + strMinutos;
        } else {
          strMinutos = "00" + strMinutos;
        }

        strHoras = strHoras.replaceAll(".", "");

        showView = "$strHoras" + ":" + "$strMinutos";
      }

      num1 = "00:00";
      num2 = "00:00";
      typedButton = "00:00";
    } else {
      if (typedButton.length >= 4) {
        if (typedButton.length == 4) {
          typedButton = typedButton + btnVal;
          typedButton = typedButton.substring(0, 3) + ":" + typedButton.substring(3);
        }
      } else {
        typedButton = typedButton + btnVal;
      }
    }

    setState(() {
      appearsScreen = typedButton;
      controller.text = appearsScreen;
    });
  }

  static MaskTextInputFormatter getHorasMask() {
    var maskFormatter = MaskTextInputFormatter(mask: '###:##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);
    return maskFormatter;
  }
}
