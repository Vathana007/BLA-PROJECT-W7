import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidePreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  final List<RidePreference> _pastPreferences = [];

  final RidePreferencesRepository repository;

  RidePreferencesProvider({required this.repository}) {
     // Initialize the _pastPreferences list from repository
    _pastPreferences.addAll(repository.getPastPreferences());
  }

  // Method to get currentPreference
  RidePreference? get currentPreference => _currentPreference;

  // Set currentPreference
  void setCurrentPreference(RidePreference pref) {
    if (currentPreference != pref) {
      _currentPreference = pref;
    }

    bool isHistory = _pastPreferences.contains(pref);
    if (!isHistory) {
      _pastPreferences.add(pref);
    }

    notifyListeners();
  }

  // Add a new preference
  void addPreference(RidePreference preference) {
    repository.addPreference(preference);
    _pastPreferences.add(preference);
    notifyListeners();
  }

  // Get the past preferences (from the newest to the lasted)
  List<RidePreference> get preferencesHistory =>
      _pastPreferences.reversed.toList();

}
