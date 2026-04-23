import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'providers/auth_provider.dart';
import 'providers/lesson_provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/phrase_provider.dart';
import 'providers/topic_provider.dart';
import 'providers/reward_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesson_list_screen.dart';
import 'screens/lesson_detail_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/course_screen.dart';
import 'screens/exercise_screen.dart';
import 'screens/listening_screen.dart';
import 'screens/ai_assignment_screen.dart';
import 'screens/topics_screen.dart';
import 'screens/rewards_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProxyProvider<AuthProvider, LessonProvider>(
          create: (context) => LessonProvider(context.read<AuthProvider>()),
          update: (context, auth, previous) => previous ?? LessonProvider(auth),
        ),
        ChangeNotifierProxyProvider<AuthProvider, QuizProvider>(
          create: (context) => QuizProvider(context.read<AuthProvider>()),
          update: (context, auth, previous) => previous ?? QuizProvider(auth),
        ),
        ChangeNotifierProxyProvider<AuthProvider, PhraseProvider>(
          create: (context) => PhraseProvider(context.read<AuthProvider>()),
          update: (context, auth, previous) => previous ?? PhraseProvider(auth),
        ),
        ChangeNotifierProxyProvider<AuthProvider, AppState>(
          create: (context) => AppState(context.read<AuthProvider>()),
          update: (context, auth, previous) => previous ?? AppState(auth),
        ),
        ChangeNotifierProvider(create: (_) => TopicProvider()),
        ChangeNotifierProvider(create: (_) => RewardProvider()),
      ],
      child: MaterialApp(
        title: 'English Learning App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthWrapper(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/topics': (context) => TopicsScreen(),
          '/rewards': (context) => RewardsScreen(),
          '/lessons': (context) => const LessonListScreen(),
          '/quiz': (context) => const QuizScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/courses': (context) => const CourseScreen(),
          '/exercises': (context) => const ExerciseScreen(),
          '/listening': (context) => const ListeningScreen(),
          '/ai': (context) => const AIAssignmentScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return authProvider.isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}
