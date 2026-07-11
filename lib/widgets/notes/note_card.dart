import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/session_note.dart';

class NoteCard extends StatelessWidget {

  final SessionNote note;

  const NoteCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      child: Padding(

        padding: const EdgeInsets.all(18),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Row(

              children: const [

                CircleAvatar(
                  child: Icon(Icons.note),
                ),

                SizedBox(width: 10),

                Text(
                  "Consultation Note",
                  style: TextStyle(
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

              ],

            ),

            const SizedBox(height: 18),

            Text(
              note.note,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            Row(

              children: [

                const Icon(
                  Icons.schedule,
                  size: 18,
                ),

                const SizedBox(width: 8),

                Text(
                  DateFormat(
                    "dd MMM yyyy • hh:mm a",
                  ).format(
                    note.createdAt,
                  ),
                ),

              ],

            )

          ],

        ),

      ),

    );

  }

}