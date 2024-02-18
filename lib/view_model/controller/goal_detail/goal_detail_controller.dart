// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class EditGoaController with ChangeNotifier {
  Future<void> editGoalDetailDialog(BuildContext context, String goalId) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    bool isLoading = true;

    // Fetch goal data from Firestore
    DocumentSnapshot goalSnapshot = await FirebaseFirestore.instance
        .collection('User')
        .doc(SessionController().user.uid.toString())
        .collection('goals')
        .doc(goalId)
        .get();

    // Populate text fields with goal data
    titleController.text = goalSnapshot['goalTitle'] ?? '';
    descriptionController.text = goalSnapshot['goalDescription'] ?? '';
    isLoading = false;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Goal Details'),
            content: isLoading
                ? CircularProgressIndicator() // Show loading indicator
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(hintText: 'Enter title'),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: descriptionController,
                        decoration:
                            InputDecoration(hintText: 'Enter description'),
                      ),
                    ],
                  ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () async {
                  // Update goal details in Firestore
                  await FirebaseFirestore.instance
                      .collection('User')
                      .doc(SessionController().user.uid.toString())
                      .collection('goals')
                      .doc(goalId)
                      .update({
                    'goalTitle': titleController.text.trim(),
                    'goalDescription': descriptionController.text.trim(),
                  });

                  // Update goal details in all documents of the "tasks" collection
                  QuerySnapshot tasksSnapshot = await FirebaseFirestore.instance
                      .collection('User')
                      .doc(SessionController().user.uid.toString())
                      .collection('goals')
                      .doc(goalId)
                      .collection('tasks')
                      .where('goalId', isEqualTo: goalId)
                      .get();

                  for (QueryDocumentSnapshot task in tasksSnapshot.docs) {
                    await task.reference.update({
                      'goalName': titleController.text.trim(),
                      'goalDescription': descriptionController.text.trim(),
                    });
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
