import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../Domain/interfaces/school_data_source.dart';
import '../../../Domain/entities/news_item.dart';
import '../../../Domain/entities/lesson.dart';

class SqlSchoolDataSource implements SchoolDataSource {
  static const String _newsTable = 'news';
  static const String _lessonsTable = 'lessons';

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'school.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    // Create news table
    await db.execute('''
      CREATE TABLE $_newsTable (
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT,
        date TEXT
      )
    ''');

    // Create lessons table
    await db.execute('''
      CREATE TABLE $_lessonsTable (
        id INTEGER PRIMARY KEY,
        subject TEXT,
        teacher TEXT,
        room TEXT,
        startHour INTEGER,
        startMinute INTEGER,
        endHour INTEGER,
        endMinute INTEGER,
        dayOfWeek INTEGER
      )
    ''');
  }

  @override
  Future<void> saveNews(List<NewsItem> news) async {
    final db = await database;

    // Clear existing news
    await db.delete(_newsTable);

    // Insert new news
    for (final item in news) {
      await db.insert(_newsTable, {
        'id': item.id,
        'title': item.title,
        'content': item.content,
        'date': item.date.toIso8601String(),
      });
    }
  }

  @override
  Future<List<NewsItem>> getNews() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_newsTable);

    return List.generate(maps.length, (i) {
      return NewsItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        date: DateTime.parse(maps[i]['date']),
      );
    });
  }

  @override
  Future<void> clearNews() async {
    final db = await database;
    await db.delete(_newsTable);
  }

  @override
  Future<void> saveLessons(List<Lesson> lessons) async {
    final db = await database;

    // Clear existing lessons
    await db.delete(_lessonsTable);

    // Insert new lessons
    for (final lesson in lessons) {
      await db.insert(_lessonsTable, {
        'id': lesson.id,
        'subject': lesson.title,
        'teacher': lesson.teacher,
        'room': lesson.room,
        'startHour': lesson.startTime.hour,
        'startMinute': lesson.startTime.minute,
        'endHour': lesson.endTime.hour,
        'endMinute': lesson.endTime.minute,
        'dayOfWeek': lesson.dayOfWeek,
      });
    }
  }

  @override
  Future<List<Lesson>> getLessons() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_lessonsTable);

    return List.generate(maps.length, (i) {
      return Lesson(
        id: maps[i]['id'],
        title: maps[i]['subject'],
        teacher: maps[i]['teacher'],
        room: maps[i]['room'],
        startTime: Time(
          hour: maps[i]['startHour'] ?? 0,
          minute: maps[i]['startMinute'] ?? 0,
        ),
        endTime: Time(
          hour: maps[i]['endHour'] ?? 0,
          minute: maps[i]['endMinute'] ?? 0,
        ),
        dayOfWeek: maps[i]['dayOfWeek'],
      );
    });
  }

  @override
  Future<void> clearLessons() async {
    final db = await database;
    await db.delete(_lessonsTable);
  }
}