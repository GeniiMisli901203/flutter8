import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/services.dart';
import 'package:flutter5/service_locator.dart';
import 'package:go_router/go_router.dart';
import '../../../../Domain/entities/user_profile.dart';
import '../state/profile_store.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileStore = getIt<ProfileStore>();

    // При открытии экрана загружаем данные из хранилища
    WidgetsBinding.instance.addPostFrameCallback((_) {
      profileStore.loadProfile(); // Изменено на loadProfile()
    });

    return Observer(
      builder: (context) {
        final profile = profileStore.userProfile; // Изменено на userProfile

        if (profileStore.isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Профиль'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Проверяем, есть ли профиль
        if (profile == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Профиль'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_off, size: 80, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text(
                    'Профиль не найден',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => profileStore.loadProfile(),
                    child: const Text('Загрузить профиль'),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Профиль'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.grade),
                onPressed: () {
                  context.push('/grades');
                },
                tooltip: 'Мои оценки',
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditProfileDialog(context, profileStore, profile);
                },
                tooltip: 'Редактировать профиль',
              ),
              // Кнопка обновления данных из хранилища
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  profileStore.loadProfile();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Профиль обновлен из хранилища'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Обновить данные',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Аватар (можно использовать дефолтную картинку или генерировать по инициалам)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.1),
                      border: Border.all(color: Colors.blue, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(profile),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    profile.fullName, // Используем fullName из UserProfile
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: Text(
                      'Класс: ${profile.className}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Text(
                      'Школа: ${profile.school}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: Text(
                      'Логин: ${profile.login}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Кнопки остаются без изменений
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push('/grades');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.assessment),
                      label: const Text(
                        'Мои оценки',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push('/requests');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.request_page),
                      label: const Text(
                        'Мои заявки',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push('/support');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.support_agent),
                      label: const Text(
                        'Техподдержка',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.push('/extra-education');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.school),
                      label: const Text(
                        'Дополнительное образование',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            Icons.person,
                            'Имя',
                            '${profile.firstName} ${profile.lastName}',
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.school,
                            'Школа',
                            profile.school,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.class_,
                            'Класс',
                            profile.className,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.email,
                            'Email',
                            profile.email,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.phone,
                            'Телефон',
                            profile.phone,
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            Icons.person_pin,
                            'Логин',
                            profile.login,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Кнопка для отладки - посмотреть все данные из хранилища
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: OutlinedButton(
                      onPressed: () async {
                        try {
                          final allData = await profileStore.getProfileData();
                          _showStorageDataDialog(context, allData);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Ошибка: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: const Text('Показать данные профиля'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Вспомогательный метод для получения инициалов
  String _getInitials(UserProfile profile) {
    final firstName = profile.firstName.isNotEmpty ? profile.firstName[0] : '';
    final lastName = profile.lastName.isNotEmpty ? profile.lastName[0] : '';
    return '$firstName$lastName'.toUpperCase();
  }

  // Упрощенный метод _buildInfoRow с иконками вместо картинок
  Widget _buildInfoRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Иконка
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.withOpacity(0.1),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
            ),
            child: Center(
              child: Icon(icon, color: Colors.blue, size: 24),
            ),
          ),
          const SizedBox(width: 16),
          // Текстовая информация
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, ProfileStore profileStore, UserProfile profile) {
    // Разделяем полное имя на имя и фамилию
    TextEditingController firstNameController = TextEditingController(text: profile.firstName);
    TextEditingController lastNameController = TextEditingController(text: profile.lastName);
    TextEditingController classController = TextEditingController(text: profile.className);
    TextEditingController emailController = TextEditingController(text: profile.email);
    TextEditingController phoneController = TextEditingController(text: profile.phone);
    TextEditingController schoolController = TextEditingController(text: profile.school);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать профиль'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'Имя'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Фамилия'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: classController,
                decoration: const InputDecoration(labelText: 'Класс'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Телефон'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: schoolController,
                decoration: const InputDecoration(labelText: 'Школа'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await profileStore.updateProfile(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  className: classController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  school: schoolController.text,
                );

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Профиль успешно обновлен'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ошибка при обновлении: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showStorageDataDialog(BuildContext context, Map<String, String> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Данные профиля'),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxHeight: 400),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final key = data.keys.elementAt(index);
              final value = data[key];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(
                    key,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(value ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: value ?? ''));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Скопировано в буфер обмена'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}