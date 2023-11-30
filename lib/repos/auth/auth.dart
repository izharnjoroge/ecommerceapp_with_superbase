import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final supabase = Supabase.instance.client;

  Future<String> signUp(
      String userEmail, String password, String username) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        // phone: phone,
        email: userEmail,
        password: password,
        data: {'username': username},
      );
      final Session? session = res.session;
      final User? user = res.user;

      return 'Welcome';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final Session? session = res.session;
      final User? user = res.user;
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signInWithOtp(String phone) async {
    await supabase.auth.signInWithOtp(
      phone: phone,
    );
  }

  Future<String> veryfyOtp(String otp, String phone) async {
    final AuthResponse res = await supabase.auth.verifyOTP(
      type: OtpType.sms,
      token: otp,
      phone: phone,
    );
    final Session? session = res.session;
    final User? user = res.user;

    if (res == '200') {
      return 'success';
    }
    return 'failed';
  }

  Future<void> resendOtp(String phone) async {
    final ResendResponse res = await supabase.auth.resend(
      type: OtpType.sms,
      phone: phone,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
