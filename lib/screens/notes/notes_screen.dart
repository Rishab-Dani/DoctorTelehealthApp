import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class NotesScreen extends StatefulWidget {

  final String appointmentId;

  const NotesScreen({
    super.key,
    required this.appointmentId,
  });

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  final controller = TextEditingController();

  final List<String> notes = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Session Notes"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            CustomTextField(
              controller: controller,
              hint: "Enter Session Note",
              maxLines: 4,
            ),

            const SizedBox(height: 20),

            CustomButton(

              title: "Save Note",

              icon: Icons.save,

              onPressed: () {

                if(controller.text.trim().isEmpty) return;

                setState(() {

                  notes.add(controller.text);

                  controller.clear();

                });

              },

            ),

            const SizedBox(height: 20),

            Expanded(

              child: ListView.builder(

                itemCount: notes.length,

                itemBuilder: (context,index){

                  return Card(

                    child: ListTile(

                      leading: const Icon(Icons.note),

                      title: Text(notes[index]),

                    ),

                  );

                },

              ),

            )

          ],
        ),
      ),
    );
  }
}