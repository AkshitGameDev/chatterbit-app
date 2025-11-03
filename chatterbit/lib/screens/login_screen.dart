import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState()=>_LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController(), password = TextEditingController();
  String? err;
  @override Widget build(BuildContext c){
    final auth = context.watch<AuthState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: email, decoration: const InputDecoration(labelText:'Email')),
          const SizedBox(height:12),
          TextField(controller: password, decoration: const InputDecoration(labelText:'Password'), obscureText: true),
          const SizedBox(height:12),
          if (err!=null) Text(err!, style: const TextStyle(color: Colors.red)),
          FilledButton(
            onPressed: auth.loading ? null : () async {
              setState(() => err=null);
              try { await context.read<AuthState>().login(email.text.trim(), password.text); }
              catch(e){ setState(()=>err=e.toString()); }
            },
            child: auth.loading? const CircularProgressIndicator() : const Text('Login')),
          TextButton(onPressed: ()=>Navigator.pushReplacementNamed(c,'/signup'), child: const Text('Create account')),
        ]),
      )),
    );
  }
}
