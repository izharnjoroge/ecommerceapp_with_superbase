import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final supabase = Supabase.instance.client;

  Future<String> signUp(
      String userEmail, String password, String phone, String username) async {
    final AuthResponse res = await supabase.auth.signUp(
      phone: phone,
      password: password,
      data: {'username': username},
    );
    final Session? session = res.session;
    final User? user = res.user;

    return user!.id;
  }

  Future<String> signIn(String phone, String password) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      phone: phone,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    return user!.id;
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
