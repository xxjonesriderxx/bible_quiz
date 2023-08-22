import 'dart:async';

import 'package:games_services/games_services.dart';

class TimerScoreCalculator {
  static TimerScoreCalculator? _instance;
  Timer? _timer;
  int _seconds;
  int _score;

  TimerScoreCalculator._()
      : _seconds = 10,
        _score = 0;

  static TimerScoreCalculator get instance {
    if (_instance == null) {
      _instance = TimerScoreCalculator._();
    }
    return _instance!;
  }

  void startCounting() {
    _seconds = 10;
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<int> submitScore() async {
    int backup = _score;
    await Leaderboards.submitScore(score: Score(androidLeaderboardID: 'CgkI74ydo6IBEAIQAQ', value: _score));
    _reset();
    return backup;
  }

  void _reset() {
    _timer?.cancel();
    _seconds = 15;
    _score = 0;
  }

  int stopCounting(bool rightAnswer) {
    _timer?.cancel();
    if (rightAnswer) {
      int score = _seconds * 2;
      _score += score;
      return score;
    }
    return 0;
  }
}
