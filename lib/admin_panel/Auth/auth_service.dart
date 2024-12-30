


import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
    final SupabaseClient _supabase = Supabase.instance.client;

    // Sign in

    Future<AuthResponse> signInWithEmailPassword(String email,String password) async{
        return await _supabase.auth.signInWithPassword(
            email: email,
            password: password
            );
    }
    
    // Register
    Future<AuthResponse> registerWithEmailPassword(String email,String password) async{
        return await _supabase.auth.signUp(
            email: email,
            password: password
            );
    }

    //Sign Out
    Future<void> signOut() async{
        await _supabase.auth.signOut();
    }

    String? getCurrentUserEmail(){
        final session = _supabase.auth.currentSession;
        final user = session?.user;
        return user?.email;
    }
}