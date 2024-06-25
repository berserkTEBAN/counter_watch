import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class CounterCubit extends Cubit<int> {
  final int maxLimit = 10;
  final int minLimit = -10;

  CounterCubit() : super(0);

  void increment() {
    if (state < maxLimit) {
      emit(state + 1);
    } else {
      _showToast('Alcanzaste el máximo');
    }
  }

  void decrement() {
    if (state > minLimit) {
      emit(state - 1);
    } else {
      _showToast('Llegaste al mínimo');
    }
  }

  void reset() {
    emit(0);
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Color.fromARGB(255, 44, 216, 164),
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }
}
