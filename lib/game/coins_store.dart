import 'package:word_twist/data/user_prefs.dart';

const _kPoints = 100;
const _kCoinsKey = 'coins';
const kCoinsForOneMin = 5;
const kCoinsEarnedForRewardAd = 2;
const kCoinsForPoints = 1;

class CoinsStore {
  final UserPrefs _userPrefs;

  int _lastLevel = 0;
  int _coins = 0;

  int get coins => _coins;

  CoinsStore(this._userPrefs) {
    _coins = _userPrefs.getInt(_kCoinsKey) ?? 20;
  }

  int scoreChanged(int newScore) {
    final newLevel = newScore ~/ _kPoints;    
    if (newLevel > _lastLevel) {
      coinEarned(kCoinsForPoints);
      _lastLevel = newLevel;
    }
    return kCoinsForPoints;
  }

  void onRewardedVideoPlayed() {
    coinEarned(kCoinsEarnedForRewardAd);
  }

  void coinEarned(int amount) {    
    _coins += amount;
    _userPrefs.setInt(_kCoinsKey, _coins);
  }

  bool consumeCoins(int amount) {
    if (amount > _coins) {
      return false;
    }
    _coins -= amount;
    _userPrefs.setInt(_kCoinsKey, _coins);
    return true;
  }

  void reset() {
    _lastLevel = 0;
  }
}
