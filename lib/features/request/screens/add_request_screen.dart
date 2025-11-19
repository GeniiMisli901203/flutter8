import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import 'package:go_router/go_router.dart';

import '../state/requests_store.dart';

class AddRequestScreen extends StatefulWidget {
  const AddRequestScreen({Key? key}) : super(key: key);

  @override
  State<AddRequestScreen> createState() => _AddRequestScreenState();
}

class _AddRequestScreenState extends State<AddRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  RequestCategory _selectedCategory = RequestCategory.technical;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final requestsStore = getIt<RequestsStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Создать заявку'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _submitForm(requestsStore),
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          if (requestsStore.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<RequestCategory>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Категория',
                      border: OutlineInputBorder(),
                    ),
                    items: RequestCategory.values
                        .map(
                          (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.displayName),
                      ),
                    )
                        .toList(),
                    onChanged: (category) {
                      if (category != null) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Заголовок заявки',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите заголовок';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Описание проблемы',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите описание';
                      }
                      if (value.length < 10) {
                        return 'Описание должно содержать не менее 10 символов';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () => _submitForm(requestsStore),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.send),
                      label: const Text(
                        'Отправить заявку',
                        style: TextStyle(fontSize: 16),
                      ),
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

  void _submitForm(RequestsStore store) async {
    if (_formKey.currentState!.validate()) {
      await store.addRequest(
        title: _titleController.text,
        description: _descriptionController.text,
        category: _selectedCategory,
      );

      if (mounted) {
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Заявка успешно создана!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}