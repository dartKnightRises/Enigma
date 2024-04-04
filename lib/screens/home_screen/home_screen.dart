import '../../common_libraries.dart'; // Importing other common libraries.
import '../../local_auth/auth_controller.dart'; // Importing the AuthController class.

// Defining a StatefulWidget for the HomeScreen.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// State class for the HomeScreen.
class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  AuthController authController =
      Get.find(); // Finding the AuthController instance.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addObserver(this); // Adding observer for app lifecycle state changes.
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(
        this); // Removing observer for app lifecycle state changes.
    super.dispose();
  }

  // Method to handle app lifecycle state changes.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Check authentication status when app resumes
      if (!authController.booleanIsAuthorize.value) {
        Get.offNamed('/'); // Navigating to landing screen if not authorized.
      }
    }
  }

  // Building the UI scaffold for the HomeScreen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'), // Setting app bar title.
      ),
      body: const Center(
        child: Text('Welcome to Home Screen!'), // Displaying welcome message.
      ),
    );
  }
}
