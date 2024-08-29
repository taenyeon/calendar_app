import 'package:calendar_app/entity/jwt_token.dart';
import 'package:calendar_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MainPage extends ConsumerWidget {
  MainPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    JwtToken jwtToken = ref.watch(authViewModelProvider);
    AuthViewModel authViewModel = ref.read(authViewModelProvider.notifier);
    authViewModel.init();

    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (jwtToken.isAuthorized) ...[
              const Text('isAutholized'),
              Text('accessToken : ${jwtToken.accessToken}'),
              Text('refreshToken : ${jwtToken.refreshToken}'),
              ElevatedButton(
                onPressed: () => context.go('/calendar'),
                child: const Text('Calendar'),
              )
            ] else ...[
              const Text('isUnAutholized'),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'username'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'password'),
              ),
              ElevatedButton(
                  onPressed: () => {
                        authViewModel.login(
                          _usernameController.text,
                          _passwordController.text,
                        )
                      },
                  child: const Text('Login')),
            ]
          ],
        ),
      ),
    );
  }
}
