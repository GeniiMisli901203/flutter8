import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';

import '../state/support_store.dart';

class ChatSupportScreen extends StatefulWidget {
  const ChatSupportScreen({Key? key}) : super(key: key);

  @override
  State<ChatSupportScreen> createState() => _ChatSupportScreenState();
}

class _ChatSupportScreenState extends State<ChatSupportScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final supportStore = getIt<SupportStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат с поддержкой'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              supportStore.clearChat();
            },
            tooltip: 'Очистить историю',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (context) {
                _scrollToBottom();
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: supportStore.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = supportStore.chatMessages[index];
                    return _buildMessageBubble(message);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(supportStore),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(SupportMessage message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: message.isUserMessage
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isUserMessage) ...[
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.support_agent, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUserMessage
                    ? Colors.blue
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUserMessage
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: message.isUserMessage
                          ? Colors.white70
                          : Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUserMessage) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 16, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(SupportStore store) {
    return Observer(
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Введите ваше сообщение...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: (_) => _sendMessage(store),
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: store.isLoading ? Colors.grey : Colors.blue,
                foregroundColor: Colors.white,
                child: IconButton(
                  icon: store.isLoading
                      ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.send),
                  onPressed: store.isLoading
                      ? null
                      : () => _sendMessage(store),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _sendMessage(SupportStore store) async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    await store.sendMessage(text);
    _messageController.clear();
  }

  String _formatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}