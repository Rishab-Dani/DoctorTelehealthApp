import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../models/session_note.dart';
import '../../providers/session_note_provider.dart';

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

  final TextEditingController controller =
  TextEditingController();

  @override
  Widget build(BuildContext context) {

    final provider =
    Provider.of<SessionNoteProvider>(
      context,
      listen: false,
    );

    return Scaffold(

      appBar: AppBar(
        title: const Text("Session Notes"),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: controller,

              maxLines: 4,

              decoration: InputDecoration(

                hintText: "Write session note...",

                border: OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(12),

                ),

              ),

            ),

            const SizedBox(height: 15),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                icon: const Icon(Icons.save),

                label: const Text("Save Note"),

                onPressed: () async {

                  if(controller.text.trim().isEmpty){

                    return;

                  }

                  await provider.addNote(

                    widget.appointmentId,

                    controller.text.trim(),

                  );

                  controller.clear();

                },

              ),

            ),

            const SizedBox(height:20),

            Expanded(

              child: StreamBuilder<List<SessionNote>>(

                stream: provider.notes(
                  widget.appointmentId,
                ),

                builder: (context,snapshot){

                  if(snapshot.connectionState==
                      ConnectionState.waiting){

                    return const Center(

                      child:
                      CircularProgressIndicator(),

                    );

                  }

                  if(snapshot.hasError){

                    return Center(

                      child:
                      Text(snapshot.error.toString()),

                    );

                  }

                  final notes =
                      snapshot.data ?? [];

                  if(notes.isEmpty){

                    return const Center(

                      child: Text(
                        "No Session Notes",
                      ),

                    );

                  }

                  return ListView.builder(

                    itemCount: notes.length,

                    itemBuilder: (context,index){

                      final note = notes[index];

                      return Card(

                        elevation:2,

                        child: ListTile(

                          leading: const CircleAvatar(

                            child: Icon(Icons.note),

                          ),

                          title: Text(
                            note.note,
                          ),

                          subtitle: Text(

                            DateFormat(
                              "dd MMM yyyy hh:mm a",
                            ).format(
                              note.createdAt,
                            ),

                          ),

                        ),

                      );

                    },

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