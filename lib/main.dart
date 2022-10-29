import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(title: "Simple Interest Calculator", home: SIform()));
}

class SIform extends StatefulWidget {
  const SIform({Key? key}) : super(key: key);

  @override
  State<SIform> createState() => _SIformState();
}

class _SIformState extends State<SIform> {
  var _Curriencies = ["Ruppees", "Dollar", "Pounds"];
  var _minimunPadding = 5.0;
  var _currentItemSelected = "Ruppees";

  TextEditingController Principal = TextEditingController();
  TextEditingController Roi = TextEditingController();
  TextEditingController Term = TextEditingController();

  var displayResult = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
        ),
        body: Container(
          margin: EdgeInsets.all(_minimunPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAssets(),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: Principal,
                  decoration: InputDecoration(
                      labelText: "Principal",
                      hintText: "Enter principal amount e.g. 12000",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: Roi,
                  decoration: InputDecoration(
                      labelText: "Rate Of Interest",
                      hintText: "In percent",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: Term,
                        decoration: InputDecoration(
                            labelText: "Term",
                            hintText: "Time In Years",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Container(
                      width: _minimunPadding * 5,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _Curriencies.map((String value) {
                          return DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String? newValueSelected) {
                          onDropDownItemSelected(newValueSelected);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                      width: 160.0,
                      child: Expanded(
                        child: ElevatedButton(
                          child: Text("Calculate"),
                          onPressed: () {
                            setState(() {
                              this.displayResult = _calculateTotalReturns();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                      width: 160.0,
                      child: Expanded(
                        child: ElevatedButton(
                          child: Text("Reset"),
                          onPressed: ()
                          {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimunPadding * 5,
                    bottom: _minimunPadding * 3,
                    right: _minimunPadding * 3,
                    left: _minimunPadding * 3),
                child: Center(child: Text(displayResult, style: TextStyle(fontSize: 18.0),)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAssets() {
    AssetImage assetImage = AssetImage("images/interest.png");
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );

    return Center(
        child: Container(
      margin: EdgeInsets.all(_minimunPadding * 10),
      child: image,
    ));
  }

  void onDropDownItemSelected(String? newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected!;
    });
  }

  String _calculateTotalReturns() {
    String result = "";

    try {
      double principal = double.parse(Principal.text);
      double roi = double.parse(Roi.text);
      double term = double.parse(Term.text);

      double totalAmount = principal + ((principal * roi * term) / 100);

      result =
          "After $term years, Your investment will be worth $totalAmount $_currentItemSelected";
    } catch (IOException) {
      result = "Please Enter Correct Data!!!";
    }

    return result;
  }

  void _reset()
  {
    Principal.text = "";
    Roi.text = "";
    Term.text = "";
    displayResult = "Enter Data To Calculate SI";
    _currentItemSelected = _Curriencies[0];

  }
}
