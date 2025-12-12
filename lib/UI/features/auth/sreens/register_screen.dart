import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter5/service_locator.dart';
import 'package:go_router/go_router.dart';
import '../state/auth_store.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authStore = getIt<AuthStore>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Регистрация'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Observer(
            builder: (context) {
              return Column(
                children: [
                  const SizedBox(height: 20),

                  // Поля регистрации
                  TextField(
                    onChanged: authStore.setRegisterFirstName,
                    decoration: const InputDecoration(
                      labelText: 'Имя',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    onChanged: authStore.setRegisterLastName,
                    decoration: const InputDecoration(
                      labelText: 'Фамилия',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    onChanged: authStore.setRegisterSchool,
                    decoration: const InputDecoration(
                      labelText: 'Школа',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    onChanged: authStore.setRegisterClassName,
                    decoration: const InputDecoration(
                      labelText: 'Класс',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    onChanged: authStore.setRegisterEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Электронная почта',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ПОЛЕ ДЛЯ ТЕЛЕФОНА - исправлено
                  TextField(
                    onChanged: authStore.setRegisterPhone, // Вызываем setRegisterPhone
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Номер телефона',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    onChanged: authStore.setRegisterLogin,
                    decoration: const InputDecoration(
                      labelText: 'Логин',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // ПОЛЕ ДЛЯ ПАРОЛЯ
                  TextField(
                    onChanged: authStore.setPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Пароль',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Для отладки - покажем состояние canRegister
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Observer(
                      builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Состояние регистрации:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Имя: ${authStore.registerFirstName.isNotEmpty ? "✓" : "✗"}',
                              style: TextStyle(
                                color: authStore.registerFirstName.isNotEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              'Фамилия: ${authStore.registerLastName.isNotEmpty ? "✓" : "✗"}',
                              style: TextStyle(
                                color: authStore.registerLastName.isNotEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              'Email: ${authStore.registerEmail.isNotEmpty ? "✓" : "✗"}',
                              style: TextStyle(
                                color: authStore.registerEmail.isNotEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              'Телефон: ${authStore.registerPhone.isNotEmpty ? "✓" : "✗"}',
                              style: TextStyle(
                                color: authStore.registerPhone.isNotEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              'Школа: ${authStore.registerSchool.isNotEmpty ? "✓" : "✗"}',
                              style: TextStyle(
                                color: authStore.registerSchool.isNotEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              'Класс: ${authStore.registerClassName.isNotEmpty ? "✓" : "✗"}',
                              style: TextStyle(
                                color: authStore.registerClassName.isNotEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              'Логин: ${authStore.registerLogin.isNotEmpty ? "✓" : "✗"}',
                              style: TextStyle(
                                color: authStore.registerLogin.isNotEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                            Text(
                              'Пароль: ${authStore.password.isNotEmpty ? "✓" : "✗"}',
                              style: TextStyle(
                                color: authStore.password.isNotEmpty ? Colors.green : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Можно регистрироваться: ${authStore.canRegister ? "ДА" : "НЕТ"}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: authStore.canRegister ? Colors.green : Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Кнопка регистрации
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authStore.canRegister && !authStore.isLoading
                          ? () async {
                        await authStore.registerUser();
                        if (authStore.isLoggedIn) {
                          context.go('/main');
                        }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: authStore.canRegister ? Colors.green : Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: authStore.isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : const Text(
                        'Зарегистрироваться',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}