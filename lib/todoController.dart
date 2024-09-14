import 'package:flutter/material.dart';
import 'package:flutter_app2/home.dart';
import 'package:flutter_app2/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app2/todoController.dart';




class TodoController extends GetxController {
  final TextEditingController valueShowController = TextEditingController();
  SharedPreferences? _prefs;

  var note = <String>[].obs;
  final String validEmail = "user@example.com";
  final String validPassword = "password123";

  TodoController() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> loadToDos() async {
    if (_prefs != null) {
      final List<String>? savedNotes = _prefs!.getStringList('todos');
      if (savedNotes != null) {
        note.addAll(savedNotes);
      }
    }
  }

  Future<void> saveToDos() async {
    if (_prefs != null) {
      await _prefs!.setStringList('todos', note);
    }
  }

  void addFuntion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New To-Do'),
          backgroundColor: Colors.grey.shade200,
          content: TextField(
            controller: valueShowController,
            decoration: const InputDecoration(hintText: 'Enter to-do'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (valueShowController.text.isNotEmpty) {
                  note.add(valueShowController.text); // Add the new to-do
                  valueShowController.clear(); // Clear the controller
                  saveToDos(); // Save the updated list to SharedPreferences
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void updateFunction(BuildContext context, int index) {
    valueShowController.text = note[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit To-Do'),
          content: TextField(
            controller: valueShowController,
            decoration: const InputDecoration(hintText: 'Enter to-do'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (valueShowController.text.isNotEmpty) {
                  note[index] = valueShowController.text;
                  valueShowController.clear(); // Clear the controller
                  saveToDos(); // Save the updated list
                }
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void deleteFunction(int index) {
    note.removeAt(index); // Remove the to-do item
    saveToDos(); // Save after deleting
  }

  Future<void> login(BuildContext context, String email, String password) async {
    if (email == validEmail && password == validPassword) {
      // Store login state in SharedPreferences
      if (_prefs != null) {
        await _prefs!.setBool('isLoggedIn', true);
        Get.to(() => const HomeScreen());
      }
    } else {
      // Show login error
      Get.snackbar("Login Error", "Invalid email or password");
    }
  }

  void logout(BuildContext context) async {
    if (_prefs != null) {
      await _prefs!.setBool('isLoggedIn', false);
      Get.offAll(() => const LogInPage()); // Redirect to login screen
    }
  }
}
