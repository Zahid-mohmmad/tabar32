import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/admin/screens/admin_screen.dart';
import 'package:e_commerce_app/features/auth/auth_screen.dart';
import 'package:e_commerce_app/features/home/screens/home_screen.dart';
import 'package:e_commerce_app/features/services/auth_service.dart';
import 'package:e_commerce_app/features/stripe/constatnts/constants.dart';
import 'package:e_commerce_app/features/widgets/bottom_bar.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Ensure widgets are bound before calling runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set the publishable key directly
  Stripe.publishableKey = publishableKey;

  // Check if the publishable key is not empty or null
  if (Stripe.publishableKey.isEmpty) {
    throw Exception('Stripe publishable key is not set');
  } else {
    print('Stripe publishable key: $publishableKey');
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final AuthService authservice = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authservice.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E commerce App',
        theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme:
              const ColorScheme.dark(primary: GlobalVariables.secondaryColor),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const AdminScreen()
            : const AuthScreen());
  }
}
