// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserProvider extends ChangeNotifier {
//   late SharedPreferences prefs;
//   String _firstName = '';
//   String _userId = '';

//   // final Ref _read;

//   UserProvider(this.prefs) {
//     loadData();
//   }

//   get firstName => _firstName;
//   get userId => _userId;

//   void loadData() async {
//     await Future.wait([
//       getData().catchError((e) {
//         log(e.toString());
//       }),
//     ]).then((value) {});
//   }

//   Future<void> getData() async {
//     // final sharedPreferences = prefs.getString('firstName');
//     _firstName = prefs.getString('firstName') ?? '';
//     // _firstName = sharedPreferences.getString('firstName') ?? '';
//     _userId = prefs.getString('userId') ?? '';
//     // ... rest of the data loading
//     notifyListeners();
//   }

//   void setFirstName(String value) async {
//     await prefs.setString('firstName', value);
//     _firstName = value;

//     notifyListeners();
//   }

//   void setUserId(String value) async {
//     await prefs.setString('userId', value);
//     _userId = value;

//     notifyListeners();
//   }

//   // Future<bool> setUserId(String value) {
//   //   _userId = value;
//   //   notifyListeners();
//   //   final sharedPreferences = _read.read(sharedPreferencesProvider);
//   //   return sharedPreferences.setString('userId', value);
//   // }

//   // Future<bool> resetUser() async {
//   //   final sharedPreferences = _read.read(sharedPreferencesProvider);
//   //   sharedPreferences.remove('firstName');
//   //   return sharedPreferences.remove('userId');
//   // }
// }

// final sharedPerefence =
//     FutureProvider((ref) => SharedPreferences.getInstance());

// final userProvider = ChangeNotifierProvider<UserProvider>((ref) {
//   final prefs = ref.watch(sharedPerefence).asData!.value;
//   return UserProvider(prefs);
// });
// // final userProvider = ChangeNotifierProvider<UserProvider>((ref) {
// //   return UserProvider(ref);
// // });

// // final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
// //   throw UnimplementedError('SharedPreferences is not implemented yet');
// // });

// // class UserProvider extends ChangeNotifier {
// //   String _firstName = '';
// //   String _userId = '';

// //   final Ref _read;

// //   UserProvider(this._read) {
// //     loadData();
// //   }

// //   get firstName => _firstName;
// //   get userId => _userId;

// //   void loadData() async {
// //     await Future.wait([
// //       getData().catchError((e) {
// //         log(e.toString());
// //       }),
// //     ]).then((value) {});
// //   }

// //   Future<void> getData() async {
// //     final sharedPreferences = _read.read(sharedPreferencesProvider);
// //     _firstName = sharedPreferences.getString('firstName') ?? '';
// //     _userId = sharedPreferences.getString('userId') ?? '';

// //     // ... rest of the data loading
// //     notifyListeners();
// //   }

// //   Future<bool> setFirstName(String value) {
// //     _firstName = value;
// //     notifyListeners();
// //     final sharedPreferences = _read.read(sharedPreferencesProvider);
// //     return sharedPreferences.setString('firstName', value);
// //   }

// //   Future<bool> setUserId(String value) {
// //     _userId = value;
// //     notifyListeners();
// //     final sharedPreferences = _read.read(sharedPreferencesProvider);
// //     return sharedPreferences.setString('userId', value);
// //   }

// //   Future<bool> resetUser() async {
// //     final sharedPreferences = _read.read(sharedPreferencesProvider);
// //     sharedPreferences.remove('firstName');
// //     return sharedPreferences.remove('userId');
// //   }
// // }