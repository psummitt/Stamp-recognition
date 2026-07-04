import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/stamp_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StampProvider>(context);
    final history = provider.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection History'),
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'No history yet. Start by detecting some stamps!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                final dateStr = DateFormat('yMMMd').add_jm().format(item.timestamp);

                return Semantics(
                  label: 'Detection on $dateStr for file ${item.fileName}',
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ExpansionTile(
                      leading: Semantics(
                        excludeSemantics: true,
                        child: const Icon(Icons.history, color: Colors.blue),
                      ),
                      title: Text(
                        item.fileName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(dateStr),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Status: ${item.result.status}'),
                              if (item.result.error != null)
                                Text('Error: ${item.result.error}',
                                    style: const TextStyle(color: Colors.red)),
                              const Divider(),
                              ...item.result.data.map((stamp) => Semantics(
                                    label: 'Stamp ${stamp.stampIndex}: ${stamp.error ?? (stamp.data['stamp_name'] ?? 'Identified')}',
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.label_important, size: 16),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'Stamp ${stamp.stampIndex}: ${stamp.error ?? stamp.data['stamp_name'] ?? 'Unknown'}',
                                            ),
                                          ),
                                          if (stamp.data['accuracy'] != null)
                                            Text(
                                              '${(stamp.data['accuracy'] * 100).toStringAsFixed(1)}%',
                                              style: const TextStyle(color: Colors.green),
                                            ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
