const String profileTable = '''
  CREATE TABLE IF NOT EXISTS profile (
    id INTEGER PRIMARY KEY, 
    username TEXT,
    description TEXT,
    imageID INTEGER,
    pathCode TEXT
  );
''';
