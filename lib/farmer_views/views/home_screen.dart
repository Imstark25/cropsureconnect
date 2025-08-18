
// The main app widget that sets up the provider and determines the initial screen.
import 'package:flutter/cupertino.dart';

class CropsureConnectApp extends StatelessWidget {
  const CropsureConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FarmerAuthController()),
      ],
      child: MaterialApp(
        title: 'CropsureConnect',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Inter',
        ),
        home: Consumer<FarmerAuthController>(
          builder: (context, authController, child) {
            // Check the authentication state
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                // If a user is logged in, show the home screen, otherwise show the login screen.
                if (snapshot.hasData) {
                  return const HomeScreen(); // You will implement this screen
                }
                return const LoginScreen();
              },
            );
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
