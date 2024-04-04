
import '../../common_libraries.dart'; // Importing other common libraries.
import 'local_auth/auth_controller.dart'; // Importing the AuthController class.

// Main function to run the application.
void main() {
  runApp(MyApp()); // Running the MyApp widget.
}

// MyApp class representing the root widget of the application.
class MyApp extends StatelessWidget {
  final AuthController authController = Get.put(AuthController()); // Initializing AuthController.

  MyApp({super.key}); // Constructor.

  // Building the root widget of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Setting debug banner to false.
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController()); // Initializing AuthController during app startup.
      }),
      initialRoute: Routes.landing, // Setting the initial route to landing.
      getPages: Routes.routes, // Defining application routes.
    );
  }
}
