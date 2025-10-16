import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

class AuthController {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final LocalAuthentication _localAuth = LocalAuthentication();

  /// Use NIF as a synthetic email: nif@sa_trabalho.local
  static String _emailFromNif(String nif) => '$nif@sa_trabalho.local';

  static Future<UserCredential> signInWithNifAndPassword(String nif, String password) async {
    final email = _emailFromNif(nif);
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // Create user automatically for demo purposes
        final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        return cred;
      }
      rethrow;
    }
  }

  /// Simple biometric flow: authenticates locally and returns the current Firebase user
  /// If no Firebase user exists, caller should ask user to sign in with NIF/password first.
  static Future<bool> authenticateWithBiometrics() async {
    final canCheck = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    if (!canCheck || !isDeviceSupported) return false;
    final didAuthenticate = await _localAuth.authenticate(
      localizedReason: 'Autentique-se para acessar o app',
      options: const AuthenticationOptions(biometricOnly: true),
    );
    return didAuthenticate;
  }

  static User? get currentUser => _auth.currentUser;

  static Future<void> signOut() => _auth.signOut();
}
