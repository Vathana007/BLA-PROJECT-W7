import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3_blabla_project/data/dto/ride_preferenc_dto.dart';
import 'package:week_3_blabla_project/data/repository/preference_repository.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'dart:convert';

import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class LocalRidePreferencesRepository implements RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final prefsList = prefs.getStringList(_preferencesKey) ?? [];
      
      return prefsList.map((json) {
        final jsonMap = jsonDecode(json) as Map<String, dynamic>;
        return RidePreferenceDto.fromJson(jsonMap);
      }).toList();
    } catch (e) {
      print('Error loading preferences: $e');
      return [];
    }
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final preferences = await getPastPreferences();
      
      // Prevent duplicates if needed
      if (!preferences.any((p) => 
          p.departure == preference.departure &&
          p.arrival == preference.arrival &&
          p.departureDate == preference.departureDate)) {
        
        preferences.add(preference);
        
        await prefs.setStringList(
          _preferencesKey,
          preferences.map((p) => jsonEncode(RidePreferenceDto.toJson(p))).toList(),
        );
      }
    } catch (e) {
      print('Error saving preference: $e');
      rethrow;
    }
  }
}