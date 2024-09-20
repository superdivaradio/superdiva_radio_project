import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:superdiva_radio/constants/language.dart';
import 'package:superdiva_radio/constants/theme.dart';

class TimerView extends StatefulWidget {
  const TimerView({Key? key}) : super(key: key);
  static const routeName = '/timer';

  @override
  TimerViewState createState() => TimerViewState();
}

class TimerViewState extends State<TimerView> {
  late final viewModel = Provider.of<TimerProvider>(context, listen: true);
  late final width = MediaQuery.of(context).size.width - 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        title: const Text(Language.sleepTime),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            _buildSlider(),
            const Spacer(flex: 2),
            _buildButton(
              title: Language.startTimer,
              visible: viewModel.timer?.isActive != true,
              color: AppTheme.timerTrackColor,
              textColor: AppTheme.foregroundColor,
              onTap: () {
                viewModel.startTimer();
              },
            ),
            _buildButton(
              title: Language.stopTimer,
              visible: viewModel.timer?.isActive == true,
              color: AppTheme.timerTrackInativeColor,
              textColor: AppTheme.foregroundColor,
              onTap: () {
                viewModel.stopTimer();
              },
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 260,
        startAngle: 270,
        angleRange: 360,
        customWidths: CustomSliderWidths(
          trackWidth: 5,
          progressBarWidth: 20,
          handlerSize: 16,
          shadowWidth: 42,
        ),
        customColors: CustomSliderColors(
          trackColor: AppTheme.timerTrackColor,
          progressBarColor: AppTheme.progressBarColor,
          shadowColor: AppTheme.shadowColor,
          dotColor: AppTheme.controlColor,
          shadowMaxOpacity: 0.1,
        ),
      ),
      onChange: (double value) {
        viewModel.setTimer(Duration(seconds: value.toInt()));
      },
      initialValue: viewModel.timerDuration.inSeconds.toDouble(),
      min: 0,
      max: 14400,
      innerWidget: (value) {
        return _buildCenterText();
      },
    );
  }

  Widget _buildCenterText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Language.timeLeft,
          style: TextStyle(
            color: AppTheme.timerTrackColor,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          viewModel.timerDuration.format(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppTheme.timerTrackColor,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String title,
    required bool visible,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Visibility(
      visible: visible,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(textColor),
          backgroundColor: WidgetStateProperty.all<Color>(color),
          minimumSize: WidgetStateProperty.all<Size>(const Size(180, 40)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
        onPressed: onTap,
        icon: const Icon(
          Icons.bedtime,
          size: 24.0,
        ),
        label: Text(title),
      ),
    );
  }
}

extension DurationExtension on Duration {
  String format() {
    final hours = inHours;
    final minutes = inMinutes % 60;
    final seconds = inSeconds % 60;

    return '${hours.toString().padLeft(2, "0")}:${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}';
  }
}

class TimerProvider with ChangeNotifier {
  late VoidCallback onTimer;
  Timer? timer;
  Duration timerDuration = const Duration(hours: 0, minutes: 5);
  final timerPeriod = const Duration(seconds: 1);

  void setTimer(Duration value) {
    timerDuration = value;
    notifyListeners();
  }

  void startTimer() {
    timer = Timer.periodic(timerPeriod, onTick);
    notifyListeners();
  }

  void stopTimer() {
    timer?.cancel();
    notifyListeners();
  }

  void onTick(Timer timer) {
    if (timerDuration == Duration.zero) {
      onTimer();
      stopTimer();
    } else {
      timerDuration -= timerPeriod;
      notifyListeners();
    }
  }
}