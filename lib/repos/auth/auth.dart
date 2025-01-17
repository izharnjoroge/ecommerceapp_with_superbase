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

  Future<String> signIn(String email) async {
    try {
      await supabase.auth.signInWithOtp(
        email: email,
        shouldCreateUser: false,
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

  Future<String> verifyOtp(String otp, String email) async {
    try {
      await supabase.auth.verifyOTP(
        type: OtpType.email,
        token: otp,
        email: email,
      );
      return 'verified';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> resendOtp(String email) async {
    // final ResendResponse res = await supabase.auth.resend(
    //   type: OtpType.sms,
    //   phone: phone,
    // )
    try {
      await supabase.auth.resend(
        type: OtpType.email,
        email: email,
      );
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<String> deleteAccount() async {
    try {
      await supabase.functions.invoke('delete_user_account');
      return 'successful';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> forgotPassword(String email) async {
    try {
      await supabase.auth.resetPasswordForEmail(email);
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateUserDetails(
    String? username,
    String? phone,
    String? area,
    String? street,
  ) async {
    try {
      await supabase.auth.updateUser(UserAttributes(data: {
        'username': username ?? '',
        'area': area ?? '',
        'street': street ?? '',
        'phone': phone ?? '',
      }));
      return 'updated';
    } catch (e) {
      return e.toString();
    }
  }
}
