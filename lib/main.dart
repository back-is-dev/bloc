import 'package:flutter/material.dart';

import 'counter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();
  @override
  void dispose() {
    CounterBloc().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<Object>(
                //wrap the existing text with a stream builder
                stream: counterBloc.counterStream,
                initialData: 0,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              // counterBloc.counterSink.add(_counter);
              counterBloc.eventSink.add(CounterAction.Increment);
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              // counterBloc.counterSink.add(_counter);
              counterBloc.eventSink.add(CounterAction.Decrement);
            },
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              // counterBloc.counterSink.add(_counter);
              counterBloc.eventSink.add(CounterAction.Reset);
            },
            tooltip: 'Reset',
            child: Icon(Icons.loop),
          ),
        ],
      ),
    );
  }
}
