import 'package:flutter/material.dart';
import 'package:tipcalculator/widget/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _currentValue = 0;
  double tip = 0;
  double billamount = 0;
  int split = 1;
  double totalperperson = 0;
  num totalamount = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: height,
          width: width,
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue.withOpacity(0.1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total per person',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "\$ ${totalperperson.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue.withOpacity(0.2)),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: ((String value) {
                        if (value.isEmpty) {
                          _currentValue = 0;
                          tip = 0;
                          billamount = 0;
                          split = 1;
                          totalperperson = 0;
                          totalamount = 0;

                          setState(() {});
                        } else {
                          print(value);
                          billamount = double.parse(value);
                          setState(() {
                            totaltipcalculation();
                            totalamountcalculation();
                            perpersoncalculation(); // Update all calculations
                          });
                        }
                      }),
                      decoration: InputDecoration(
                          label: Text('Bill Amount'),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Split:'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (split > 1) {
                                      split--;
                                      setState(() {});
                                      setState(() {
                                        totaltipcalculation();
                                        totalamountcalculation();
                                        perpersoncalculation(); // Update all calculations
                                      });
                                    }
                                  });
                                },
                                child: Button(title: '-')),
                            SizedBox(
                              width: 10,
                            ),
                            Text(split.toString()),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    split++;
                                    totaltipcalculation();
                                    totalamountcalculation();
                                    perpersoncalculation();
                                  });
                                },
                                child: Button(title: '+')),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tip'),
                        Text(
                          '\$ ${tip}',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Text(
                      '${_currentValue.toString()} %',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                    ),
                    Slider(
                      min: 0,
                      max: 100,
                      activeColor: Colors.blueAccent.withOpacity(0.7),
                      inactiveColor: Colors.blueAccent.withOpacity(0.3),
                      divisions: 10,
                      value: _currentValue,
                      onChanged: (value) {
                        setState(() {
                          print('currentvalue: $_currentValue');
                          _currentValue = value;
                          print('value: $value');
                          totaltipcalculation();
                          totalamountcalculation();
                          perpersoncalculation();
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue.withOpacity(0.1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total Bill with Tip:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "\$ ${totalamount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void totaltipcalculation() {
    tip = (billamount * _currentValue) / 100;
  }

  void totalamountcalculation() {
    totalamount = billamount + tip;
  }

  void perpersoncalculation() {
    totalperperson = totalamount / split;
  }
}
