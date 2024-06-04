import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final supabase = Supabase.instance.client;

  Future<String> signUp(
    String userEmail,
    String password,
    String? username,
    String phone,
    String? area,
    String? street,
  ) async {
    try {
      await supabase.auth.signUp(
        email: userEmail,
        password: password,
        data: {
          'username': username,
          'phone': phone,
          'area': area ?? '',
          'street': street ?? ''
        },
      );
      return 'Welcome';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
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

  Future<String> verifyOtp(String otp, String phone) async {
    try {
      await supabase.auth.verifyOTP(
        type: OtpType.sms,
        token: otp,
        phone: phone,
      );
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> resendOtp(String phone) async {
    // final ResendResponse res = await supabase.auth.resend(
    //   type: OtpType.sms,
    //   phone: phone,
    // )
    try {
      await supabase.auth.resend(
        type: OtpType.sms,
        phone: phone,
      );
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<String> forgotPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }
}
