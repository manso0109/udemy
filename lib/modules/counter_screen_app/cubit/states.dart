abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterPlusState extends CounterStates {
  final int counter;
  CounterPlusState(this.counter);
}

// عشان استقبله فى ال UI
class CounterMinusState extends CounterStates {
  final int counter;
  CounterMinusState(this.counter);
}
