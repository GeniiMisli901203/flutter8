import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import '../../../state/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = getIt<AppState>();

    return Observer(
      builder: (context) {
        final profile = appState.studentProfile;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Профиль'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditProfileDialog(context, appState);
                },
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
                  CachedNetworkImage(
                    imageUrl: 'https://yt3.googleusercontent.com/vgi-AL9ssRi0KYHfCgERa955Nm2q6gVbsFmDqQPhsptU4hgc1g3dyRazdc6wlefzLBrNlo9-MA=s900-c-k-c0x00ffffff-no-rj',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 3),
                        color: Colors.grey[300],
                      ),
                      child: const Icon(Icons.person_outline, size: 60, color: Colors.blue),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 3),
                        color: Colors.grey[300],
                      ),
                      child: const Icon(Icons.error_outline, size: 60, color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    profile.name,
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
                  const SizedBox(height: 32),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildInfoRow('https://i.pinimg.com/736x/c2/16/d2/c216d2e11724197af3fa7414c47ea1a0.jpg', 'О себе', 'Я люблю есть печенье'),
                          const SizedBox(height: 16),
                          _buildInfoRow('https://i.ytimg.com/vi/RIwUVygucO4/maxresdefault.jpg', 'Школа №123', 'С углубленным изучением математики'),
                          const SizedBox(height: 16),
                          _buildInfoRow('https://storage.myseldon.com/news-pict-3c/3C8882CBFAE5963A29CDE6A320BB271E', 'Email', profile.email),
                          const SizedBox(height: 16),
                          _buildInfoRow('https://i.pinimg.com/originals/a1/ae/d9/a1aed90e81aca243355a45a092d35f3c.jpg', 'Телефон', profile.phoneNumber),
                        ],
                      ),
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

  Widget _buildInfoRow(String url, String title, String subtitle) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: CachedNetworkImage(
            imageUrl: url,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const Icon(Icons.person_outline, size: 20, color: Colors.blue),
            errorWidget: (context, url, error) => const Icon(Icons.error_outline, size: 20, color: Colors.red),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showEditProfileDialog(BuildContext context, AppState appState) {
    final profile = appState.studentProfile;

    TextEditingController nameController = TextEditingController(text: profile.name);
    TextEditingController classController = TextEditingController(text: profile.className);
    TextEditingController emailController = TextEditingController(text: profile.email);
    TextEditingController phoneController = TextEditingController(text: profile.phoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Редактировать профиль'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            TextField(
              controller: classController,
              decoration: const InputDecoration(labelText: 'Класс'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Телефон'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              appState.updateStudentProfile(
                name: nameController.text,
                className: classController.text,
                email: emailController.text,
                phoneNumber: phoneController.text,
              );
              Navigator.of(context).pop();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}