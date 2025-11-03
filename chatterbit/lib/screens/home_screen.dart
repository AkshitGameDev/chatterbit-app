import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) { // <-- use `context` here
    final auth = context.watch<AuthState>(); // <-- now valid
    final u = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Chatterbit')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Signed in as ${u?['email']}'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => auth.logout(),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
