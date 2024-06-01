import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider {
  final SupabaseClient supabaseClient;

  AuthProvider(this.supabaseClient);

  Stream<AuthState> get authStateStream =>
      supabaseClient.auth.onAuthStateChange;
}
