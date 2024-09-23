import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp()); 

Future<String> loadAsset() async {
  return await rootBundle.loadString('images/rain1.png');
}

/* return const Image(image: AssetImage('images/rain1.png')); */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  String _message = ''; 
  TextEditingController _incrementController = TextEditingController();

bool _showimage = true;

  void _incrementCounter() {
   
    int incrementValue = int.tryParse(_incrementController.text) ?? 0;

    setState(() {
      if (_counter + incrementValue <= 100) {
        _counter += incrementValue;
        _message = ''; 
      } else {
        _counter = 100;
        _message = 'Maximum limit achieved'; 
      }
      _incrementController.clear(); 
    });
  }

  void _toggleimage(){
    setState(() {
      _showimage = !_showimage;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '$_counter',
                style: TextStyle(fontSize: 50.0, color: Colors.white),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                if (value <= 100) {
                  _counter = value.toInt();
                  _message = ''; 
                }
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _incrementController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Set Increment Value',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 5),

          Image.asset(
          _showimage ? 'images/rain1.png' : 'images/rain2.png',  // Path to the image file | Operator Checker (Hence the: ?)
          height: 150,          // Set the desired height of the image
          ),
            
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: _toggleimage,


              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Text('Toggle Image'),
            ),
          ),

          ElevatedButton(
            onPressed: _incrementCounter,
            child: Text('Increment Counter'),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_counter > 0) {
                    _counter--; 
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Text('Decrease Counter'),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter = 0; 
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Text('Reset Counter'),
            ),
          ),
          SizedBox(height: 5),
          Text(
            _counter == 100 ? 'Maximum limit achieved' : _message,
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ],
      ),
    );
  }
}