import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as Rive;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late Rive.RiveAnimationController _controller;
  late AnimationController _animationController;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller = Rive.OneShotAnimation("active");

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
            (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("Login error: ${e.message}");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 420,
            width: 350,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.greenAccent[100],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, size: 30, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'email',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.email, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.black),
                    prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                      : const Text(
                    'Login',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_add_alt_1_outlined, size: 20, color: Colors.black),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupPage())
                        );
                      },
                      child: const Text("Sign up?", style: TextStyle(fontSize: 16, color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text("Follow us on", style: TextStyle(fontSize: 16, color: Colors.black)),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                    SizedBox(width: 12),
                    Icon(FontAwesomeIcons.instagram, color: Colors.pink),
                    SizedBox(width: 12),
                    Icon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.green[100],
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _animation,
                      child: Icon(Icons.eco, size: 100, color: Colors.green[800]),
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Welcome Farmer!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    FadeTransition(
                      opacity: _animation,
                      child: Text(
                        'Login to manage your crops',
                        style: TextStyle(fontSize: 16, color: Colors.green[600]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 110,
            bottom: 200,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Rive.RiveAnimation.asset(
                "assets/button.riv",
                controllers: [_controller],
              ),
            ),
          ),
          const Positioned(
            left: 130,
            bottom: 115,
            child: SizedBox(
              width: 180,
              height: 200,
              child: Text(
                "GET STARTED!",
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            left: 110,
            bottom: 250,
            child: GestureDetector(
              onTap: () {
                _controller.isActive = true;
                _showDialog(context);
              },
              child: Container(
                width: 200,
                height: 100,
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
