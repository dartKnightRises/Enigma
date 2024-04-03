
import '../../common_libraries.dart';
import '../../local_auth/auth_controller.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Text(
                'Enigma',
                style: $styles.text.homeIntroLineOne,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
               Text(
                $styles.appConstants.appDescription,
                style: $styles.text.homeIntroLineTwo,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: authController.authenticate,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: const CircleBorder(),
                  elevation: 10,

                ),
                child: Ink(
                  decoration:  ShapeDecoration(
                    color: $styles.colors.offWhite,
                    shape: const CircleBorder(),
                  ),
                  child: const IconButton(
                    icon: Icon(Icons.fingerprint, size: 40),
                    onPressed: null,
                    // color: Theme.of(context).primaryColor,
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
