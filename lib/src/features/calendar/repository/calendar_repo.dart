import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

final calendarRepoProvider = Provider((_) => CalendarRepository());
final storage = FirebaseStorage.instance;
final storageRef = FirebaseStorage.instance.ref();

class CalendarRepository {

}