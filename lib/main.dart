import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:convert' as convert;
import './datepicker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

var settings = new ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '18140699',
    db: 'mydb');
var conn = MySqlConnection.connect(settings);

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController Name = TextEditingController();
  final TextEditingController Surname = TextEditingController();
  final TextEditingController Pincode = TextEditingController();
  final TextEditingController Phone = TextEditingController();

  int _counter = 0;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Male';
  String dropdownValue1 = 'A+';
  String dropdownValue2 = 'Dust';
  String dropdownValue3 = 'BP';
  DateTime selectedDate = new DateTime.now();
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Card(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  ),
                  controller: Name,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Surname *',
                  ),
                  controller: Surname,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                      ),
                      Expanded(child: DatePickerDemo())
                    ]),
                Row(children: <Widget>[
                  Icon(
                    Icons.family_restroom_rounded,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: dropdownValue,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Male', 'Female', 'Others']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  )
                ]),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter pincode',
                    labelText: 'Pincode *',
                  ),
                  controller: Pincode,
                  validator: (value) {
                    if (value.length != 6 || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Enter Phone number',
                    labelText: 'Phone *',
                  ),
                  controller: Phone,
                  validator: (value) {
                    if (value.length != 10 || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
                Row(children: <Widget>[
                  Icon(
                    Icons.family_restroom_rounded,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                        value: dropdownValue1,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue1 = newValue;
                          });
                        },
                        items: <String>[
                          'A+',
                          'B+',
                          'AB+',
                          'AB-',
                          'O+',
                          'O-',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  )
                ]),
                Row(children: <Widget>[
                  Icon(
                    Icons.family_restroom_rounded,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                        value: dropdownValue2,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue2 = newValue;
                          });
                        },
                        items: <String>[
                          'Dust',
                          'Pollen',
                          'Water',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  )
                ]),
                Row(children: <Widget>[
                  Icon(
                    Icons.family_restroom_rounded,
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                        value: dropdownValue3,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue3 = newValue;
                          });
                        },
                        items: <String>['BP', 'HBP', 'LBP', 'Heart']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  )
                ]),
                ElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      // ScaffoldMessenger.of(context)
                      //     .showSnackBar(SnackBar(content: Text('Data Recieved')));

                      //form values
                      final String Name1 = Name.text;
                      final String Surname1 = Surname.text;
                      final String Pincode1 = Pincode.text;
                      final String Phone1 = Phone.text;
                      final String DOB = selectedDate.toString();
                      final String Gender = dropdownValue;
                      final String BloodGroup = dropdownValue1;
                      final String Alergies = dropdownValue2;
                      final String Comorbidity = dropdownValue3;

                      // ADD YOUR API URL HERE AND CREATE JSON OBJECT OF THE ABOVE DATA AND SEND
                      var url = Uri.https('www.googleapis.com',
                          '/books/v1/volumes', {'q': '{http}'});

                      // Await the http get response, then decode the json-formatted response.
                      var response = await http.get(url);
                      if (response.statusCode == 200) {
                        var jsonResponse = convert.jsonDecode(response.body)
                            as Map<String, dynamic>;
                        var itemCount = jsonResponse['totalItems'];
                        print('Number of books about http: $itemCount.');
                      } else {
                        print(
                            'Request failed with status: ${response.statusCode}.');
                      }

                      // ignore: non_constant_identifier_names

                      setState(() {});
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
