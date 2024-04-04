import 'package:local_auth/local_auth.dart'; // Importing the package for local authentication.

import '../common_libraries.dart'; // Importing other common libraries.

// Defining a class AuthController which extends GetxController and implements WidgetsBindingObserver.
class AuthController extends GetxController with WidgetsBindingObserver {

  final LocalAuthentication auth = LocalAuthentication(); // Initializing LocalAuthentication object.

  // Rx variables for managing state.
  Rx<SupportState> supportState = Rx<SupportState>(SupportState.unknown);
  RxBool? boolCanCheckBiometrics;
  RxList<BiometricType>? biometricTypeAvailableBiometrics;
  RxString stringAuthorized = RxString('Not Authorized');
  RxBool booleanIsAuthenticating = RxBool(false);
  RxBool booleanIsAuthorize = RxBool(false);

  // Lifecycle method called when the controller is initialized.
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this); // Adding observer for app lifecycle state changes.
    checkBiometrics(); // Calling a method to check biometric capabilities.
  }

  // Lifecycle method called when the controller is closed.
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this); // Removing observer for app lifecycle state changes.
    super.onClose();
  }

  // Method to handle app lifecycle state changes.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      revokeAuthorization(); // Revoking authorization when the app is paused.
    }
  }

  // Method to check if biometric authentication is available on the device.
  Future<void> checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }

    boolCanCheckBiometrics = canCheckBiometrics.obs;

    if (boolCanCheckBiometrics!.value) {
      getAvailableBiometrics(); // If biometric check is available, get available biometric types.
    }
  }

  // Method to get available biometric types on the device.
  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }

    biometricTypeAvailableBiometrics = availableBiometrics.obs;
  }

  // Method to authenticate using any available method (e.g., pin, fingerprint, face ID).
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      booleanIsAuthenticating.value = true;
      stringAuthorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason: 'Only You Can See Your Data',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      booleanIsAuthenticating.value = false;
    } on PlatformException catch (e) {
      print(e);
      booleanIsAuthenticating.value = false;
      stringAuthorized.value = 'Error - ${e.message}';
      return;
    }

    stringAuthorized.value = authenticated ? 'Authorized' : 'Not Authorized';
    booleanIsAuthorize.value = authenticated ? true : false;
    if (booleanIsAuthorize.value) Get.offNamed('/home'); // Navigating to home if authorized.
  }

  // Method to authenticate using biometric methods only.
  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      booleanIsAuthenticating.value = true;
      stringAuthorized.value = 'Authenticating';

      authenticated = await auth.authenticate(
        localizedReason:
        'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      booleanIsAuthenticating.value = false;
    } on PlatformException catch (e) {
      print(e);
      booleanIsAuthenticating.value = false;
      stringAuthorized.value = 'Error - ${e.message}';
      return;
    }

    stringAuthorized.value = authenticated ? 'Authorized' : 'Not Authorized';
    booleanIsAuthorize.value = authenticated ? true : false;
    if (booleanIsAuthorize.value) Get.offNamed('/home'); // Navigating to home if authorized.
  }

  // Method to cancel ongoing authentication process.
  void cancelAuthentication() async {
    await auth.stopAuthentication();
    booleanIsAuthenticating.value = false;
  }

  // Method to revoke authorization.
  void revokeAuthorization() {
    if (booleanIsAuthenticating.value) {
      cancelAuthentication();
    }

    // Additional cleanup logic if needed
    // For example, you may want to clear any saved tokens or flags
    stringAuthorized.value = 'Not Authorized';
    booleanIsAuthorize.value = false;
  }
}

// Enum to represent the state of biometric support.
enum SupportState {
  unknown,
  supported,
  unsupported,
}
