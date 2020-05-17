import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Calculator App",
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State createState() =>  HomePageState();
}

class HomePageState extends State<HomePage>{
  String input="", saveStr="";
  bool inputtingNum = false;

  void _clear() {
    setState(() {
      input="";
    });
  }

  void _back() {
    setState(() {
      input = input.substring(0, input.length - 1);
    });
  }

  void _push(String ch){
    setState(() {
      if(input.isEmpty && ch != '0')
        input += ch;
     else if(input.isNotEmpty)
        input += ch;
    });
  }

  void _sign(){
    setState(() {
      if(input.substring(0,1) != "-" && input.substring(0,1) != "0")
        input = "-" + input;
      else if(input.substring(0,1) == "-")
        input = input.substring(1, input.length);
    });
  }

  void _shortequal() {
    setState(() {
      if(inputtingNum == true) {
        saveStr = input;
        input = "";
        inputtingNum = false;
      }
      else {
        print(saveStr);
        input = saveStr;
        print(input);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color.fromRGBO(66, 73, 124, 15), Color.fromRGBO(26, 30, 90, 1)])),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              constraints:  BoxConstraints.expand(
                height: Theme.of(context).textTheme.headline4.fontSize * 1.1 + 100.0,
              ),
              alignment: Alignment.bottomRight,
              child:  Text(
                input,
                style:  TextStyle(
                  fontSize: 55.0, fontFamily: 'Nunito', color:Colors.white,
                ),
                textAlign: TextAlign.right,

              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _modify("C", _clear),
                _negorpos("+/-", _sign),
                _operator("/", _push),
                _operator("x", _push)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _digit("7", _push),
                _digit("8", _push),
                _digit("9", _push),
                _operator("+", _push)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _digit("4", _push),
                _digit("5", _push),
                _digit("6", _push),
                _operator("-", _push)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _digit("1", _push),
                _digit("2", _push),
                _digit("3", _push),
                _operator("%", _push)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _modify("<-", _back),
                _digit("0", _push),
                _digit(".", _push),
                _equal("=", _shortequal)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _modify (String number, Function() f) {
    return Container (
        height: 75.0,
        child: RaisedButton(
          child: Text(number,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, fontFamily: 'Nunito',
              )),
          textColor: Colors.red,
          color: Colors.white,
          shape: CircleBorder(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => f(),
        )
    );
  }

  Widget _operator (String number, Function(String) f) {
    return Container (
        height: 75.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            colors: [Color.fromRGBO(246, 137, 102, 1.0), Color.fromRGBO(253, 108, 27, 1)],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          ),
        ),
        child: FlatButton(
          child: Text(number,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, fontFamily: 'Nunito',
              )),
          textColor: Colors.white,
          color: Colors.transparent,
          shape: CircleBorder(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => f(number),
        )
    );
  }

  Widget _negorpos (String number, Function() f) {
    return Container (
        height: 75.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            colors: [Color.fromRGBO(246, 137, 102, 1.0), Color.fromRGBO(253, 108, 27, 1)],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          ),
        ),
        child: FlatButton(
          child: Text(number,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, fontFamily: 'Nunito',
              )),
          textColor: Colors.white,
          color: Colors.transparent,
          shape: CircleBorder(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => f(),
        )
    );
  }

  Widget _equal (String number, Function() f) {
    return Container (
        height: 75.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            colors: [Color.fromRGBO(244, 49, 99, 1.0), Color.fromRGBO(251, 15, 76, 1)],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          ),
        ),
        child: RaisedButton(
          child: Text(number,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, fontFamily: 'Nunito',
              )),
          textColor: Colors.white,
          color: Colors.transparent,
          shape: CircleBorder(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () => f(),
          onLongPress: () {
            inputtingNum = true;
            print("hey");
            _clear();
          },
        )
    );
  }

  Widget _digit (String number, Function(String) f) {
    return Container (
        height: 75.0,
        child:
        FlatButton(
          child: Text(number,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0, fontFamily: 'Nunito',
              )),
          textColor: Colors.white,
          color: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,

          shape: CircleBorder(),
          onPressed: () => f(number),
        )
    );
  }
}