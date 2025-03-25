import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

abstract class PreferencesRepository {
  Future<List<RidePreference>> getPastPreferences();
  Future<void> addPastPreference(RidePreference preference);
}