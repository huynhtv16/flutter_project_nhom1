import 'package:flutter/material.dart';
import 'package:bai_tap_lon/auth/widgets/auth_text_field.dart';
import 'package:bai_tap_lon/auth/widgets/auth_button.dart';
import 'package:bai_tap_lon/screens/home_screen.dart';     // ← Thêm dòng này
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),

              // Logo / Tiêu đề
              Center(
                child: Column(
                  children: [
                    Icon(Icons.school, size: 80, color: Colors.blue),
                    const SizedBox(height: 16),
                    const Text(
                      "Học Từ Vựng",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Text(
                      "Tiếng Anh mỗi ngày",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              const Text(
                "Đăng nhập",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Chào mừng bạn quay lại!",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // Email
              AuthTextField(
                hintText: "Email của bạn",
                prefixIcon: Icons.email_outlined,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 16),

              // Password
              AuthTextField(
                hintText: "Mật khẩu",
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                controller: passwordController,
              ),

              const SizedBox(height: 12),

              // Quên mật khẩu
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Quên mật khẩu?"),
                ),
              ),

              const SizedBox(height: 24),

              // ==================== NÚT ĐĂNG NHẬP ĐÃ CHỈNH ====================
              AuthButton(
                text: "Đăng nhập",
                onPressed: () {
                  // Kiểm tra đơn giản: không để trống email và password
                  if (emailController.text.trim().isEmpty ||
                      passwordController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Vui lòng nhập email và mật khẩu"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Tạm thời đăng nhập thành công → chuyển sang HomePage
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
              // =================================================================

              const SizedBox(height: 20),

              // Chuyển sang Đăng ký
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chưa có tài khoản? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Đăng ký ngay",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}