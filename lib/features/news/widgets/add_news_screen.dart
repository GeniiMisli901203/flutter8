import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import '../state/add_news_store.dart';
import '../state/news_store.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  _AddNewsScreenState createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  final AddNewsStore _addNewsStore = getIt<AddNewsStore>();
  final NewsStore _newsStore = getIt<NewsStore>();

  @override
  void initState() {
    super.initState();
    // Сбрасываем состояние формы при открытии экрана
    _addNewsStore.reset();
  }

  void _saveNews() {
    if (_formKey.currentState!.validate() && _addNewsStore.canSave) {
      _addNewsStore.setLoading(true);

      // Имитация загрузки (можно убрать в реальном приложении)
      Future.delayed(const Duration(milliseconds: 500), () {
        // Создаем новость из данных формы
        final newNews = _addNewsStore.createNewsItem();

        // Добавляем новость в основной Store
        _newsStore.addNewsToBeginning(newNews);

        // Сбрасываем форму
        _addNewsStore.reset();

        // Закрываем экран
        Navigator.of(context).pop();

        _addNewsStore.setLoading(false);
      });
    }
  }

  @override
  void dispose() {
    // Очищаем состояние при закрытии экрана
    _addNewsStore.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Добавить новость'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: _addNewsStore.isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Icon(Icons.save),
                onPressed: _addNewsStore.isLoading ? null : _saveNews,
              ),
            ],
          ),
          body: _addNewsStore.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: _addNewsStore.setTitle,
                    decoration: const InputDecoration(
                      labelText: 'Заголовок*',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите заголовок';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    onChanged: _addNewsStore.setContent,
                    decoration: const InputDecoration(
                      labelText: 'Содержание*',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите содержимое';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    onChanged: _addNewsStore.setUrl,
                    decoration: const InputDecoration(
                      labelText: 'Ссылка (опционально)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Observer(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: _addNewsStore.canSave ? _saveNews : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Сохранить новость'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}