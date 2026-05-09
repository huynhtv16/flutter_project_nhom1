import 'package:flutter/material.dart';
import '../services/tts_service.dart';
import '../services/api_service.dart';
import '../models/listening_item.dart';
import '../models/course.dart';

class ListeningScreen extends StatefulWidget {
  const ListeningScreen({Key? key}) : super(key: key);

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  late Future<List<ListeningItem>> _itemsFuture;

  List<Course> _courses = [];

  @override
  void initState() {
    super.initState();
    _itemsFuture = ApiService.fetchListeningItems();
    ApiService.fetchCourses().then((list) {
      setState(() {
        _courses = list;
      });
    }).catchError((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listening Practice')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final titleCtrl = TextEditingController();
          final textCtrl = TextEditingController();
          int? selectedCourseId;

          final result = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Create Listening Item'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
                    TextField(controller: textCtrl, decoration: const InputDecoration(labelText: 'Text'), maxLines: 4),
                    const SizedBox(height: 8),
                    if (_courses.isNotEmpty)
                      DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'Course (optional)'),
                        items: _courses.map((c) => DropdownMenuItem(value: int.tryParse(c.id) ?? 0, child: Text(c.title))).toList(),
                        onChanged: (v) => selectedCourseId = v,
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () async {
                    final title = titleCtrl.text.trim();
                    if (title.isEmpty) return;
                    final payload = {
                      'title': title,
                      'text': textCtrl.text.trim(),
                      if (selectedCourseId != null) 'course_id': selectedCourseId,
                    };
                    await ApiService.createListeningItem(payload);
                    setState(() {
                      _itemsFuture = ApiService.fetchListeningItems();
                    });
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          );
          if (result == true) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Listening item created')));
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<ListeningItem>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load listening items: ${snapshot.error}'));
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(
              child: Text('No listening items available yet'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(item.text),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => TtsService.speak(item.text),
                            icon: const Icon(Icons.volume_up),
                            label: const Text('Listen'),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              final titleCtrl = TextEditingController(text: item.title);
                              final textCtrl = TextEditingController(text: item.text);
                              int? selectedCourseId = item.courseId;

                              final res = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Edit Listening Item'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
                                        TextField(controller: textCtrl, decoration: const InputDecoration(labelText: 'Text'), maxLines: 4),
                                        const SizedBox(height: 8),
                                        if (_courses.isNotEmpty)
                                          DropdownButtonFormField<int>(
                                            value: selectedCourseId,
                                            decoration: const InputDecoration(labelText: 'Course (optional)'),
                                            items: _courses.map((c) => DropdownMenuItem(value: int.tryParse(c.id) ?? 0, child: Text(c.title))).toList(),
                                            onChanged: (v) => selectedCourseId = v,
                                          ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                                    ElevatedButton(
                                      onPressed: () async {
                                        final payload = {
                                          'title': titleCtrl.text.trim(),
                                          'text': textCtrl.text.trim(),
                                          if (selectedCourseId != null) 'course_id': selectedCourseId,
                                        };
                                        await ApiService.updateListeningItem(item.id, payload);
                                        setState(() => _itemsFuture = ApiService.fetchListeningItems());
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Save'),
                                    ),
                                  ],
                                ),
                              );
                              if (res == true) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated')));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              final ok = await showDialog<bool>(
                                context: context,
                                builder: (c) => AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text('Delete this listening item?'),
                                  actions: [
                                    TextButton(onPressed: () => Navigator.of(c).pop(false), child: const Text('Cancel')),
                                    ElevatedButton(onPressed: () => Navigator.of(c).pop(true), child: const Text('Delete')),
                                  ],
                                ),
                              );
                              if (ok == true) {
                                await ApiService.deleteListeningItem(item.id);
                                setState(() => _itemsFuture = ApiService.fetchListeningItems());
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted')));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
