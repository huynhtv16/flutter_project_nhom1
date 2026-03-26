import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giới thiệu thành viên',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Thông tin thành viên'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget buildMember({
    required String name,
    required String role,
    required String image,
    required String email,
  }) {
    return Container(
      width: 180, // 👈 giảm kích thước card
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 8,
        shadowColor: Colors.blue.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // 👤 Avatar có viền
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.blue,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(image),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  role,
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 8),

                const Divider(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email, size: 14),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        email,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 🔘 Button đẹp hơn
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Liên hệ",
                    style: TextStyle(fontSize: 12),
                  ),
                )
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
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),

      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 👈 căn giữa
          children: [
            buildMember(
              name: "Huỳnh",
              role: "Trưởng nhóm",
              image: "https://i.pravatar.cc/150?img=1",
              email: "20221540@eaut.edu.vn",
            ),
            buildMember(
              name: "Hải",
              role: "Thành viên nhóm",
              image: "https://i.pravatar.cc/150?img=2",
              email: "20221607@eaut.edu.vn",
            ),
          ],
        ),
      ),
    );
  }
}