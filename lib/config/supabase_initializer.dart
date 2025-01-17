import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

bool _supabaseInitialized = false;

Future<void> initSupaBase() async {
  if (!_supabaseInitialized) {
    await Supabase.initialize(
      url: dotenv.get('PUBLIC_URL'),
      anonKey: dotenv.get('PUBLIC_KEY'),
    );
    _supabaseInitialized = true;
  }
}
