import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redrip/services/firebase_auth_service.dart';
import 'package:redrip/screens/user_selection_screen.dart';
import 'package:redrip/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // 1. Validate the form fields
    if (!_formKey.currentState!.validate()) return;

    // 2. Show loading indicator
    setState(() => _isLoading = true);

    try {
      // 3. Access the Firebase service
      final authService =
          Provider.of<FirebaseAuthService>(context, listen: false);

      // 4. Attempt real Firebase Login
      final user = await authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // 5. Handle the result
      if (user != null) {
        // Navigate to the Selection Screen on success
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const UserSelectionScreen()),
          );
        }
      } else {
        // Show error message if user is null
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Failed. Check your email/password.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Catch unexpected errors
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    } finally {
      // 6. Stop loading indicator regardless of outcome
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          // Center the content vertically
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- NEW LOGO SECTION ---
                  Image.asset(
                    'assets/logo.png',
                    height: 120, // Adjust size to fit your design
                    fit: BoxFit.contain,
                    // Fallback if the asset is missing
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.recycling,
                          size: 100, color: Colors.green);
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sustainable Fashion Marketplace',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 50),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter email';
                      if (!value.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter password';
                      if (value.length < 6)
                        return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Link
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text("Don't have an account? Sign up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
