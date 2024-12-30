



import 'package:Udyojak/admin_panel//screens/business_management_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../screens/sign_in.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange, 

      builder: (context,snapshot){

        if (snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(child: CircularProgressIndicator() ,),
          );
        }

        final session = snapshot.hasData ? snapshot.data!.session : null ;

        if (session != null){
          return BusinessManagementScreen();
        }
        else{
          return SignInScreen();
        }
      }
      );
  }
}