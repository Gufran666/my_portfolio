import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/controllers/HomeController.dart';
import '../app/repository/Database_repo.dart';

void setupDependencies() {
  Get.lazyPut<SupabaseClient>(() => Supabase.instance.client);
  Get.lazyPut<DatabaseService>(() => DatabaseService());
  Get.put(HomeController());
}