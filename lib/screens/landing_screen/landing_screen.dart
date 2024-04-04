import '../../common_libraries.dart'; // Importing other common libraries.
import '../../local_auth/auth_controller.dart'; // Importing the AuthController class.

// Defining a StatefulWidget for the LandingScreen.
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

// State class for the LandingScreen.
class _LandingScreenState extends State<LandingScreen> {
  AuthController authController = Get.find(); // Finding the AuthController instance.

  @override
  Widget build(BuildContext context) {
    // Building the UI scaffold.
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Displaying the application title.
              Text(
                'Enigma',
                style: $styles.text.homeIntroLineOne,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Adding spacing.
              // Displaying the application description.
              Text(
                $styles.appConstants.appDescription,
                style: $styles.text.homeIntroLineTwo,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40), // Adding spacing.
              // Creating an ElevatedButton for biometric authentication.
              ElevatedButton(
                onPressed: authController.authenticate, // Calling authentication method from AuthController.
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: const CircleBorder(),
                  elevation: 10,
                ),
                child: Ink(
                  decoration: ShapeDecoration(
                    color: $styles.colors.offWhite,
                    shape: const CircleBorder(),
                  ),
                  child: const IconButton(
                    icon: Icon(Icons.fingerprint, size: 40), // Fingerprint icon.
                    onPressed: null, // Button is disabled (icon only).
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
