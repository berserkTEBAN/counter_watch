import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/counter_cubit.dart';
import 'package:wearable_rotary/wearable_rotary.dart' as wearable_rotary
    show rotaryEvents;
import 'package:wearable_rotary/wearable_rotary.dart' hide rotaryEvents;

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatefulWidget {
  const CounterView({Key? key}) : super(key: key);

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  late final StreamSubscription<RotaryEvent> rotarySubscription;

  @override
  void initState() {
    super.initState();
    rotarySubscription = wearable_rotary.rotaryEvents.listen(handleRotaryEvent);
  }

  @override
  void dispose() {
    rotarySubscription.cancel();
    super.dispose();
  }

  void handleRotaryEvent(RotaryEvent event) {
    final cubit = context.read<CounterCubit>();
    if (event.direction == RotaryDirection.clockwise) {
      cubit.increment();
    } else {
      cubit.decrement();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Counter",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 44, 216, 164)),
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.read<CounterCubit>().increment(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 48, 46, 46)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      ),
                      child: const Icon(Icons.add),
                    ),
                    const SizedBox(width: 10),
                    const CounterText(),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => context.read<CounterCubit>().decrement(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 48, 46, 46)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                      ),
                      child: const Icon(Icons.remove),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => context.read<CounterCubit>().reset(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 48, 46, 46)),
                  ),
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final count = context.select((CounterCubit cubit) => cubit.state);
    return Text(
      '$count',
      style: TextStyle(fontSize: 26), // Ajuste de fontSize
    );
  }
}
