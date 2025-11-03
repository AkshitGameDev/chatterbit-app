import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/auth_state.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = AuthState(); await auth.load();
  runApp(ChangeNotifierProvider.value(value: auth, child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthState>(
      builder: (context, auth, _) {
        return MaterialApp(
          title: 'Chatterbit',
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
          home: auth.isAuthed ? const HomeScreen() : const LoginScreen(),
          routes: {
            '/login': (_) => const LoginScreen(),
            '/signup': (_) => const SignupScreen(),
            '/home': (_) => const HomeScreen(),
          },
        );
      },
    );
  }
}
