import 'package:flutter/material.dart';
import 'package:flutter5/service_locator.dart';
import 'package:go_router/go_router.dart';

import '../state/support_store.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final supportStore = getIt<SupportStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Техподдержка'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: supportStore.supportTopics.length,
        itemBuilder: (context, index) {
          final topic = supportStore.supportTopics[index];
          return _buildTopicCard(context, topic);
        },
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, SupportTopic topic) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Text(
          topic.icon,
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(topic.description),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          context.push('/support-chat');
        },
      ),
    );
  }
}