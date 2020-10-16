import 'dart:async';

enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  int counter;
  //first create an state controller which is sink
  final _stateStreamController = StreamController<int>();

  StreamSink<int> get counterSink =>
      _stateStreamController.sink; //this is a input property
  Stream<int> get counterStream =>
      _stateStreamController.stream; //this is a output of input property

  final _eventStreamController = StreamController<CounterAction>();

  StreamSink<CounterAction> get eventSink =>
      _eventStreamController.sink; //this is a input property
  Stream<CounterAction> get eventStream =>
      _eventStreamController.stream; //this is a output of input property

  CounterBloc() {
    counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.Increment)
        counter++;
      else if (event == CounterAction.Decrement) {
        if (counter <= 0) {
          counter = 0;
        }else counter--;
      } else if (event == CounterAction.Reset) counter = 0;

      counterSink.add(counter);
    });
  }
  
}
