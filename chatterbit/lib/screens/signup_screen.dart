import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/auth_state.dart';

class SignupScreen extends StatefulWidget { const SignupScreen({super.key}); @override State<SignupScreen> createState()=>_SignupScreenState(); }
class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController(), password = TextEditingController(), name = TextEditingController();
  String? err;
  @override Widget build(BuildContext c){
    final auth = context.watch<AuthState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: name, decoration: const InputDecoration(labelText:'Name')),
          const SizedBox(height:12),
          TextField(controller: email, decoration: const InputDecoration(labelText:'Email')),
          const SizedBox(height:12),
          TextField(controller: password, decoration: const InputDecoration(labelText:'Password'), obscureText: true),
          const SizedBox(height:12),
          if (err!=null) Text(err!, style: const TextStyle(color: Colors.red)),
          FilledButton(
            onPressed: auth.loading ? null : () async {
              setState(() => err=null);
              try { await context.read<AuthState>().register(email.text.trim(), password.text, name: name.text.trim()); }
              catch(e){ setState(()=>err=e.toString()); }
            },
            child: auth.loading? const CircularProgressIndicator() : const Text('Create account')),
          TextButton(onPressed: ()=>Navigator.pushReplacementNamed(c,'/login'), child: const Text('Have an account? Login')),
        ]),
      )),
    );
  }
}
