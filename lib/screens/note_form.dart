import 'package:flutter/material.dart';
import 'package:notes_app/screens/note_api.dart';

class NoteFormScreen extends StatefulWidget {
  @override
  _NoteFormScreenState createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String nom = '';
  String prenom = '';
  String classe = '';
  String matiere = '';
  double note = 0.0;
  bool isEditing = false;
  int? noteId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final noteData = ModalRoute.of(context)?.settings.arguments as Map?;
    if (noteData != null) {
      // Remplit les champs si on modifie une note existante
      nom = noteData['nom'];
      prenom = noteData['prenom'];
      classe = noteData['classe'];
      matiere = noteData['matiere'];
      note = noteData['note'].toDouble();
      noteId = noteData['id'];
      isEditing = true;
    }
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final noteData = {
        'nom': nom,
        'prenom': prenom,
        'classe': classe,
        'matiere': matiere,
        'note': note,
      };

      try {
        if (isEditing) {
          await editNote(noteId!, noteData);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Note modifiée avec succès')));
        } else {
          await addNote(noteData);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Note ajoutée avec succès')));
        }
        Navigator.pop(context); // Retourne à la liste après soumission
      } catch (error) {
        print('Erreur: $error');
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de l\'opération.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Modifier Note' : 'Ajouter Note')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom'),
                initialValue: nom,
                onSaved: (value) => nom = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer un nom' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prénom'),
                initialValue: prenom,
                onSaved: (value) => prenom = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer un prénom' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Classe'),
                initialValue: classe,
                onSaved: (value) => classe = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer une classe' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Matière'),
                initialValue: matiere,
                onSaved: (value) => matiere = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer une matière' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Note'),
                initialValue: note.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => note = double.parse(value!),
                validator: (value) =>
                    value!.isEmpty ? 'Veuillez entrer une note' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(isEditing ? 'Modifier' : 'Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

