import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  //private database variable
  static Database? _db;
  // دالة الحصول على قاعدة البيانات , بداخلها يتم اولا التاكد من انا الدالة قد انشاءت بالفعل ومن ثم يمكن الحصول عليها بشكل مؤكد
  Future<Database> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db!;
    } else {
      return _db!;
    }
  }

  //دالة بدء انشاء او تحديث اصدار قاعدة البيانات
  Future<Database> intialDb() async {
    // الجزء الاول من مسار قاعدة البيانات
    String path = await getDatabasesPath();
    //  المسار الكامل لقاعدة البيانات
    String fullPath = join(path, 'notes.db');
    // امر انشاء قاعدة البيانات او تغيير فى بنية قاعدة البيانات
    Database db = await openDatabase(
      fullPath,
      // امر انشاء قاعدة البيانات وبيتم تنفيذه مره واحدة
      onCreate: _onCreate,
      // ( _onUpgrade استخداتم) المتغير الذى يمكن من خلاله التحكم فى الاصدار الخاص بقاعدة البيانات وبيتم تغييرة فى حالة عمل تحديث لقاعدة البيانات
      version: 3,
      //  version تغيير فى بنية قاعدة البيانات لا تتم الا عند استدعاءها بنية قاعدة البيانات مع تغير ال
      onUpgrade: _onUpgrade,
    );
    return db;
  }

  // الدالة المسؤولة عن انشاء قاعدة البيانات
  Future<void> _onCreate(Database db, int version) async {
    //تستخدم فى حالة اضافة جدول او جداول لقاعدة البيانات
    Batch batch = db.batch();
    batch.execute('''
CREATE TABLE installments (
    id INTEGER PRIMARY KEY , 
    monthly_installment REAL, 
    due_date TEXT,                     
    notes TEXT                         
)
''');

    await batch.commit();
    debugPrint(
      "============================= Ccreate Table/Tables  =============================",
    );
  }
  // الدالة المسؤولة عن تعديل هيكل قاعدة البيانات عند تغيير الاصدار

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint(
      "============================= On Upgrade Database =============================",
    );
  }

  //الدالة المسؤولة عن قراءة قاعدة البيانات
  Future<List<Map<String, Object?>>> readData(String sql) async {
    Database? myDb = await db;
    List<Map<String, Object?>> response = await myDb.rawQuery(sql);
    return response;
  }

  // الدالة المسؤولة عن الاضافة داخل قاعدة البيانات وتقوم ايضا بارجاع الحالة اما تمت الاضافة او لم تتم
  Future<int> insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb.rawInsert(sql);
    return response;
  }

  // الدالة المسؤولة على التعديل ع محتوى قاعدة البيانات وتقوم ايضا بارجاع الحالة اما تم التعديل او لم تتم
  Future<int> updateData(
    int id,
    String monthlyInstallment,
    String dueDate,
    String notes,
  ) async {
    Database? myDb = await db;
    int response = await myDb.rawUpdate(
      'UPDATE installments SET monthly_installment = ?, due_date = ?, notes = ? WHERE id = ?',
      [monthlyInstallment, dueDate, notes, id],
    );
    return response;
  }

  //الدالة المسؤولة عن حذف محتوى قاعدة البيانات
  Future<int> deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb.rawDelete(sql);
    return response;
  }

  Future<void> myDeleteDatabase() async {
    // الجزء الاول من مسار قاعدة البيانات
    String path = await getDatabasesPath();
    //    المسار قاعدة البيانات الكامل لقاعدة البيانات
    String fullPath = join(path, 'notes.db');
    await deleteDatabase(fullPath);
  }
}
