import 'package:flutter/material.dart';
import 'package:bai_tap_lon/auth/widgets/auth_text_field.dart';
import 'package:bai_tap_lon/auth/widgets/auth_button.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tạo tài khoản",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Học tiếng Anh cùng chúng tôi",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 30),

                // Họ và tên
                AuthTextField(
                  hintText: "Họ và tên",
                  prefixIcon: Icons.person_outline,
                  controller: nameController,
                ),

                const SizedBox(height: 16),

                // Email
                AuthTextField(
                  hintText: "Email",
                  prefixIcon: Icons.email_outlined,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                // Mật khẩu
                AuthTextField(
                  hintText: "Mật khẩu",
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: passwordController,
                ),

                const SizedBox(height: 16),

                // Xác nhận mật khẩu
                AuthTextField(
                  hintText: "Xác nhận mật khẩu",
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                  controller: confirmPasswordController,
                ),

                const SizedBox(height: 30),

                // Nút Đăng ký
                AuthButton(
                  text: "Đăng ký",
                  onPressed: () {
                    print("Đăng ký với: ${emailController.text}");
                    // Tạm thời chỉ in ra
                  },
                ),

                const SizedBox(height: 20),

                // Chuyển sang Đăng nhập
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Đã có tài khoản? "),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}