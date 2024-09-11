import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.1.3:3000/notes';

Future<List> getNotes() async {
  final response = await http.get(Uri.parse(baseUrl));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Erreur lors du chargement des notes');
  }
}

Future<void> addNote(Map<String, dynamic> noteData) async {
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(noteData),
  );
  if (response.statusCode != 201) {
    throw Exception('Erreur lors de l\'ajout de la note');
  }
}

Future<void> editNote(int id, Map<String, dynamic> noteData) async {
  final response = await http.put(
    Uri.parse('$baseUrl/$id'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(noteData),
  );
  if (response.statusCode != 200) {
    throw Exception('Erreur lors de la modification de la note');
  }
}
// Méthode pour supprimer une note par ID
Future<void> deleteNote(int id) async {
  final response = await http.delete(Uri.parse('$baseUrl/$id'));
  if (response.statusCode != 200) {
    throw Exception('Erreur lors de la suppression de la note');
  }
}
