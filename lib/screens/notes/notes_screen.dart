import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../models/session_note.dart';
import '../../providers/session_note_provider.dart';
import '../../widgets/dashboard/dashboard_section_title.dart';
import '../../widgets/notes/empty_notes_widget.dart';
import '../../widgets/notes/note_card.dart';
import '../../widgets/notes/note_input_card.dart';
import '../../widgets/notes/notes_header.dart';

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
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SessionNoteProvider>();

    return Scaffold(
      backgroundColor: const Color(0xffF3F6FB),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Consultation Notes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),

      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,

          padding: EdgeInsets.fromLTRB(
            18,
            18,
            18,
            MediaQuery.of(context).viewInsets.bottom + 18,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              NotesHeader(
                appointmentId: widget.appointmentId,
              ),

              const SizedBox(height: 24),

              const Center(
                child: DashboardSectionTitle(
                  title: "Add Consultation Note",
                ),
              ),

              const SizedBox(height: 16),

              NoteInputCard(
                controller: controller,
                onSave: () async {
                  if (controller.text.trim().isEmpty) return;

                  await provider.addNote(
                    widget.appointmentId,
                    controller.text.trim(),
                  );

                  controller.clear();

                  if (mounted) {
                    FocusScope.of(context).unfocus();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Note Saved Successfully"),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 28),

              const Center(
                child: DashboardSectionTitle(
                  title: "Recent Notes",
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 420,
                child: StreamBuilder<List<SessionNote>>(
                  stream: provider.notes(widget.appointmentId),

                  builder: (context, snapshot) {

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    final notes = snapshot.data ?? [];

                    if (notes.isEmpty) {
                      return const EmptyNotesWidget();
                    }

                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: notes.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        return NoteCard(
                          note: notes[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}