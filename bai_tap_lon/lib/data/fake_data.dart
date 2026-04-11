import '../models/lesson.dart';
import '../models/vocabulary.dart';
import '../models/quiz.dart';
import '../models/phrase.dart';
import '../models/pronunciation_guide.dart';
import '../models/exercise.dart';

class FakeData {
  static List<Vocabulary> vocabularies = [
    // Greetings & Polite Words
    Vocabulary(id: '1', word: 'Hello', meaning: 'Xin chào', phonetic: '/həˈloʊ/', example: 'Hello, how are you?', imageUrl: 'https://via.placeholder.com/600x300.png?text=Hello', icon: 'waving_hand'),
    Vocabulary(id: '2', word: 'Goodbye', meaning: 'Tạm biệt', phonetic: '/ˌɡʊdˈbaɪ/', example: 'Goodbye, see you later.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Goodbye', icon: 'waving_hand'),
    Vocabulary(id: '3', word: 'Thank you', meaning: 'Cảm ơn', phonetic: '/ˈθæŋk juː/', example: 'Thank you for your help.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Thank+you', icon: 'handshake'),
    Vocabulary(id: '4', word: 'Please', meaning: 'Làm ơn', phonetic: '/pliːz/', example: 'Please sit down.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Please', icon: 'handshake'),
    Vocabulary(id: '5', word: 'Sorry', meaning: 'Xin lỗi', phonetic: '/ˈsɑːri/', example: 'I am sorry for being late.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Sorry', icon: 'handshake'),
    Vocabulary(id: '6', word: 'Yes', meaning: 'Có', phonetic: '/jɛs/', example: 'Yes, I agree.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Yes', icon: 'sentiment_very_satisfied'),
    Vocabulary(id: '7', word: 'No', meaning: 'Không', phonetic: '/noʊ/', example: 'No, I do not agree.', imageUrl: 'https://via.placeholder.com/600x300.png?text=No', icon: 'sentiment_very_dissatisfied'),

    // Animals
    Vocabulary(id: '8', word: 'Cat', meaning: 'Con mèo', phonetic: '/kæt/', example: 'The cat is sleeping.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Cat', icon: 'pets'),
    Vocabulary(id: '9', word: 'Dog', meaning: 'Con chó', phonetic: '/dɔːɡ/', example: 'I have a dog.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Dog', icon: 'pets'),
    Vocabulary(id: '10', word: 'Bird', meaning: 'Con chim', phonetic: '/bɜːrd/', example: 'The bird is singing.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Bird', icon: 'pets'),
    Vocabulary(id: '11', word: 'Fish', meaning: 'Con cá', phonetic: '/fɪʃ/', example: 'Fish swim in water.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Fish', icon: 'pets'),
    Vocabulary(id: '12', word: 'Elephant', meaning: 'Con voi', phonetic: '/ˈɛlɪfənt/', example: 'Elephants are large animals.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Elephant', icon: 'pets'),
    Vocabulary(id: '13', word: 'Lion', meaning: 'Con sư tử', phonetic: '/ˈlaɪən/', example: 'The lion is the king of animals.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Lion', icon: 'pets'),

    // Food & Drinks
    Vocabulary(id: '14', word: 'Apple', meaning: 'Quả táo', phonetic: '/ˈæpəl/', example: 'An apple a day keeps the doctor away.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Apple', icon: 'apple'),
    Vocabulary(id: '15', word: 'Banana', meaning: 'Quả chuối', phonetic: '/bəˈnɑːnə/', example: 'I like to eat banana.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Banana', icon: 'apple'),
    Vocabulary(id: '16', word: 'Orange', meaning: 'Quả cam', phonetic: '/ˈɔːrɪndʒ/', example: 'The orange is sweet.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Orange', icon: 'apple'),
    Vocabulary(id: '17', word: 'Water', meaning: 'Nước', phonetic: '/ˈwɔːtər/', example: 'Drink water every day.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Water', icon: 'water_drop'),
    Vocabulary(id: '18', word: 'Coffee', meaning: 'Cà phê', phonetic: '/ˈkɔːfi/', example: 'I drink coffee in the morning.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Coffee', icon: 'coffee'),
    Vocabulary(id: '19', word: 'Tea', meaning: 'Trà', phonetic: '/tiː/', example: 'She drinks tea.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Tea', icon: 'coffee'),
    Vocabulary(id: '20', word: 'Rice', meaning: 'Cơm/Lúa', phonetic: '/raɪs/', example: 'We eat rice every day.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Rice', icon: 'apple'),
    Vocabulary(id: '21', word: 'Bread', meaning: 'Bánh mì', phonetic: '/brɛd/', example: 'Bread is made from wheat.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Bread', icon: 'apple'),

    // Colors
    Vocabulary(id: '22', word: 'Red', meaning: 'Màu đỏ', phonetic: '/rɛd/', example: 'The car is red.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Red', icon: 'palette'),
    Vocabulary(id: '23', word: 'Blue', meaning: 'Màu xanh dương', phonetic: '/bluː/', example: 'The sky is blue.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Blue', icon: 'palette'),
    Vocabulary(id: '24', word: 'Green', meaning: 'Màu xanh lá', phonetic: '/ɡriːn/', example: 'The grass is green.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Green', icon: 'palette'),
    Vocabulary(id: '25', word: 'Yellow', meaning: 'Màu vàng', phonetic: '/ˈjɛloʊ/', example: 'The sun is yellow.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Yellow', icon: 'palette'),
    Vocabulary(id: '26', word: 'Black', meaning: 'Màu đen', phonetic: '/blæk/', example: 'I have a black phone.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Black', icon: 'palette'),
    Vocabulary(id: '27', word: 'White', meaning: 'Màu trắng', phonetic: '/waɪt/', example: 'Snow is white.', imageUrl: 'https://via.placeholder.com/600x300.png?text=White', icon: 'palette'),

    // Family Members
    Vocabulary(id: '28', word: 'Mother', meaning: 'Mẹ', phonetic: '/ˈmʌðər/', example: 'My mother is kind.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Mother', icon: 'person'),
    Vocabulary(id: '29', word: 'Father', meaning: 'Bố', phonetic: '/ˈfɑːðər/', example: 'My father works hard.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Father', icon: 'person'),
    Vocabulary(id: '30', word: 'Sister', meaning: 'Chị/Em gái', phonetic: '/ˈsɪstər/', example: 'My sister is a teacher.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Sister', icon: 'person'),
    Vocabulary(id: '31', word: 'Brother', meaning: 'Anh/Em trai', phonetic: '/ˈbrʌðər/', example: 'My brother plays football.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Brother', icon: 'person'),
    Vocabulary(id: '32', word: 'Grandmother', meaning: 'Bà ngoại/Bà nội', phonetic: '/ˈɡrænmʌðər/', example: 'My grandmother is 80 years old.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Grandmother', icon: 'person'),
    Vocabulary(id: '33', word: 'Grandfather', meaning: 'Ông ngoại/Ông nội', phonetic: '/ˈɡrænfɑːðər/', example: 'My grandfather tells stories.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Grandfather', icon: 'person'),

    // House & Rooms
    Vocabulary(id: '34', word: 'House', meaning: 'Nhà', phonetic: '/haʊs/', example: 'I live in a house.', imageUrl: 'https://via.placeholder.com/600x300.png?text=House', icon: 'home'),
    Vocabulary(id: '35', word: 'Room', meaning: 'Phòng', phonetic: '/ruːm/', example: 'This is my bedroom.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Room', icon: 'home'),
    Vocabulary(id: '36', word: 'Kitchen', meaning: 'Bếp', phonetic: '/ˈkɪtʃən/', example: 'We cook in the kitchen.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Kitchen', icon: 'home'),
    Vocabulary(id: '37', word: 'Bedroom', meaning: 'Phòng ngủ', phonetic: '/ˈbɛdruːm/', example: 'I sleep in the bedroom.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Bedroom', icon: 'home'),
    Vocabulary(id: '38', word: 'Bathroom', meaning: 'Phòng tắm', phonetic: '/ˈbæθruːm/', example: 'The bathroom is clean.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Bathroom', icon: 'home'),
    Vocabulary(id: '39', word: 'Door', meaning: 'Cửa', phonetic: '/dɔːr/', example: 'Please close the door.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Door', icon: 'home'),

    // School & Education
    Vocabulary(id: '40', word: 'School', meaning: 'Trường học', phonetic: '/skuːl/', example: 'I go to school every day.', imageUrl: 'https://via.placeholder.com/600x300.png?text=School', icon: 'school'),
    Vocabulary(id: '41', word: 'Book', meaning: 'Sách', phonetic: '/bʊk/', example: 'I read a book every night.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Book', icon: 'book'),
    Vocabulary(id: '42', word: 'Teacher', meaning: 'Giáo viên', phonetic: '/ˈtiːtʃər/', example: 'My teacher is very kind.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Teacher', icon: 'school'),
    Vocabulary(id: '43', word: 'Student', meaning: 'Học sinh', phonetic: '/ˈstjuːdənt/', example: 'I am a student.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Student', icon: 'school'),
    Vocabulary(id: '44', word: 'Pen', meaning: 'Bút', phonetic: '/pɛn/', example: 'Write with a pen.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Pen', icon: 'book'),
    Vocabulary(id: '45', word: 'Pencil', meaning: 'Bút chì', phonetic: '/ˈpɛnsəl/', example: 'I draw with a pencil.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Pencil', icon: 'book'),

    // Nature
    Vocabulary(id: '46', word: 'Sun', meaning: 'Mặt trời', phonetic: '/sʌn/', example: 'The sun is bright.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Sun', icon: 'wb_sunny'),
    Vocabulary(id: '47', word: 'Moon', meaning: 'Mặt trăng', phonetic: '/muːn/', example: 'The moon is bright at night.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Moon', icon: 'wb_sunny'),
    Vocabulary(id: '48', word: 'Star', meaning: 'Sao', phonetic: '/stɑːr/', example: 'There are many stars in the sky.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Star', icon: 'wb_sunny'),
    Vocabulary(id: '49', word: 'Tree', meaning: 'Cây', phonetic: '/triː/', example: 'There is a big tree in the park.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Tree', icon: 'park'),
    Vocabulary(id: '50', word: 'Flower', meaning: 'Hoa', phonetic: '/ˈflaʊər/', example: 'The flower is beautiful.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Flower', icon: 'park'),
    Vocabulary(id: '51', word: 'Water', meaning: 'Nước', phonetic: '/ˈwɔːtər/', example: 'Water is important for life.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Water', icon: 'water_drop'),

    // Transportation
    Vocabulary(id: '52', word: 'Car', meaning: 'Ô tô', phonetic: '/kɑːr/', example: 'I go to work by car.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Car', icon: 'directions_car'),
    Vocabulary(id: '53', word: 'Bus', meaning: 'Xe buýt', phonetic: '/bʌs/', example: 'I take the bus to school.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Bus', icon: 'directions_car'),
    Vocabulary(id: '54', word: 'Bicycle', meaning: 'Xe đạp', phonetic: '/ˈbaɪsɪkəl/', example: 'I ride a bicycle in the park.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Bicycle', icon: 'directions_car'),
    Vocabulary(id: '55', word: 'Train', meaning: 'Tàu hỏa', phonetic: '/treɪn/', example: 'The train is fast.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Train', icon: 'directions_car'),
    Vocabulary(id: '56', word: 'Airplane', meaning: 'Máy bay', phonetic: '/ˈɛrpleɪn/', example: 'I travel by airplane.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Airplane', icon: 'flight'),

    // Emotions & Feelings
    Vocabulary(id: '57', word: 'Happy', meaning: 'Vui vẻ', phonetic: '/ˈhæpi/', example: 'I am happy today.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Happy', icon: 'sentiment_very_satisfied'),
    Vocabulary(id: '58', word: 'Sad', meaning: 'Buồn', phonetic: '/sæd/', example: 'He is sad because he lost his pen.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Sad', icon: 'sentiment_very_dissatisfied'),
    Vocabulary(id: '59', word: 'Angry', meaning: 'Giận dữ', phonetic: '/ˈæŋɡri/', example: 'She is angry with him.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Angry', icon: 'sentiment_very_dissatisfied'),
    Vocabulary(id: '60', word: 'Tired', meaning: 'Mệt mỏi', phonetic: '/ˈtaɪərd/', example: 'I am tired after work.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Tired', icon: 'sentiment_very_dissatisfied'),
    Vocabulary(id: '61', word: 'Love', meaning: 'Yêu', phonetic: '/lʌv/', example: 'I love my family.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Love', icon: 'favorite'),

    // Sports & Activities
    Vocabulary(id: '62', word: 'Play', meaning: 'Chơi', phonetic: '/pleɪ/', example: 'I play football.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Play', icon: 'sports_soccer'),
    Vocabulary(id: '63', word: 'Dance', meaning: 'Nhảy', phonetic: '/dæns/', example: 'She loves to dance.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Dance', icon: 'sports_soccer'),
    Vocabulary(id: '64', word: 'Sing', meaning: 'Hát', phonetic: '/sɪŋ/', example: 'I sing every morning.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Sing', icon: 'music_note'),
    Vocabulary(id: '65', word: 'Read', meaning: 'Đọc', phonetic: '/riːd/', example: 'I read books in the library.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Read', icon: 'book'),
    Vocabulary(id: '66', word: 'Write', meaning: 'Viết', phonetic: '/raɪt/', example: 'Write a letter to your friend.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Write', icon: 'book'),
    Vocabulary(id: '67', word: 'Run', meaning: 'Chạy', phonetic: '/rʌn/', example: 'I run in the park.', imageUrl: 'https://via.placeholder.com/600x300.png?text=Run', icon: 'sports_soccer'),
  ];

  static List<Phrase> phrases = [
    Phrase(
      id: '1',
      phrase: 'How are you?',
      meaning: 'Bạn khỏe không?',
      example: 'How are you today?',
    ),
    Phrase(
      id: '2',
      phrase: 'Nice to meet you',
      meaning: 'Rất vui được gặp bạn',
      example: 'Nice to meet you, John.',
    ),
    Phrase(
      id: '3',
      phrase: 'What time is it?',
      meaning: 'Mấy giờ rồi?',
      example: 'What time is it now?',
    ),
  ];

  static List<PronunciationGuide> pronunciationGuides = [
    PronunciationGuide(
      id: '1',
      symbol: '/iː/',
      sound: 'ee',
      example: 'see, tree',
      description: 'Nguyên âm dài, miệng mở rộng.',
    ),
    PronunciationGuide(
      id: '2',
      symbol: '/ɪ/',
      sound: 'i',
      example: 'sit, bit',
      description: 'Nguyên âm ngắn, miệng hơi mở.',
    ),
    PronunciationGuide(
      id: '3',
      symbol: '/æ/',
      sound: 'a',
      example: 'cat, hat',
      description: 'Nguyên âm ngắn, miệng mở rộng.',
    ),
  ];

  static List<Lesson> lessons = [
    Lesson(
      id: '1',
      title: 'Basic Greetings',
      description: 'Learn basic greeting words',
      type: LessonType.vocabulary,
      vocabularyIds: ['1', '2', '3', '4', '5'],
    ),
    Lesson(
      id: '2',
      title: 'Present Simple',
      description: 'Grammar lesson on present simple tense',
      type: LessonType.grammar,
    ),
    Lesson(
      id: '3',
      title: 'Introducing Yourself',
      description: 'Communication skills for introductions',
      type: LessonType.communication,
    ),
    Lesson(
      id: '4',
      title: 'Common Phrases',
      description: 'Useful phrases and expressions',
      type: LessonType.phrase,
      phraseIds: ['1', '2', '3'],
    ),
    Lesson(
      id: '5',
      title: '3000 Common Words - Lesson 1',
      description: 'First lesson of 3000 common English words',
      type: LessonType.commonWords,
      vocabularyIds: ['6', '7', '8'],
    ),
    Lesson(
      id: '6',
      title: '3000 Common Words - Lesson 2',
      description: 'Second lesson of 3000 common English words',
      type: LessonType.commonWords,
      vocabularyIds: ['1', '6'], // Demo
    ),
    Lesson(
      id: '7',
      title: 'IPA Pronunciation Guide',
      description: 'Learn English pronunciation with IPA symbols',
      type: LessonType.pronunciation,
      pronunciationIds: ['1', '2', '3'],
    ),
  ];

  static List<Quiz> quizzes = [
    Quiz(
      id: '1',
      title: 'Greetings Quiz',
      questions: [
        QuizQuestion(
          question: 'What does "Hello" mean?',
          options: ['Xin chào', 'Tạm biệt', 'Cảm ơn', 'Xin lỗi'],
          correctIndex: 0,
          explanation: 'Hello means Xin chào in Vietnamese.',
        ),
        QuizQuestion(
          question: 'How do you say "Thank you" in English?',
          options: ['Hello', 'Goodbye', 'Thank you', 'Please'],
          correctIndex: 2,
          explanation: 'Thank you is the correct phrase.',
        ),
      ],
    ),
  ];

  static List<Exercise> exercises = [
    Exercise(
      id: '1',
      title: 'Word Matching - Greetings',
      description: 'Match English greetings with Vietnamese meanings',
      type: 'matching',
      difficulty: 1,
      duration: 5,
      questions: [
        ExerciseQuestion(
          id: '1',
          question: 'Match "Hello" with:',
          options: ['Tạm biệt', 'Xin chào', 'Cảm ơn', 'Xin lỗi'],
          correctIndex: 1,
          explanation: 'Hello = Xin chào (greeting)',
          hint: 'It is a greeting word at the beginning',
        ),
        ExerciseQuestion(
          id: '2',
          question: 'Match "Goodbye" with:',
          options: ['Xin chào', 'Xin lỗi', 'Tạm biệt', 'Cảm ơn'],
          correctIndex: 2,
          explanation: 'Goodbye = Tạm biệt (farewell)',
          hint: 'It means saying farewell',
        ),
        ExerciseQuestion(
          id: '3',
          question: 'Match "Thank you" with:',
          options: ['Xin lỗi', 'Cảm ơn', 'Xin chào', 'Tạm biệt'],
          correctIndex: 1,
          explanation: 'Thank you = Cảm ơn (gratitude)',
          hint: 'It expresses appreciation',
        ),
      ],
    ),
    Exercise(
      id: '2',
      title: 'Fill in the Blanks - Simple Present',
      description: 'Complete sentences using present simple tense',
      type: 'fillblank',
      difficulty: 2,
      duration: 8,
      questions: [
        ExerciseQuestion(
          id: '1',
          question: 'I _____ a book every day.',
          options: ['read', 'reads', 'reading', 'am reading'],
          correctIndex: 0,
          explanation: 'First person singular uses base verb "read"',
          hint: 'I/you/we/they use the base form',
        ),
        ExerciseQuestion(
          id: '2',
          question: 'She _____ to school every morning.',
          options: ['go', 'goes', 'going', 'gone'],
          correctIndex: 1,
          explanation: 'Third person singular adds -s to the verb',
          hint: 'He/She/It adds -s to the verb',
        ),
        ExerciseQuestion(
          id: '3',
          question: 'We _____ English in class.',
          options: ['study', 'studies', 'studying', 'studied'],
          correctIndex: 0,
          explanation: 'We use the base form of the verb',
          hint: 'We is a plural subject',
        ),
      ],
    ),
    Exercise(
      id: '3',
      title: 'Sentence Ordering - Common Phrases',
      description: 'Arrange words in correct order to form sentences',
      type: 'ordering',
      difficulty: 2,
      duration: 7,
      questions: [
        ExerciseQuestion(
          id: '1',
          question: 'Arrange: [are] [you] [How]',
          options: ['How you are', 'You are How', 'How are you', 'Are you how'],
          correctIndex: 2,
          explanation: 'Correct order: How are you? (Question formation)',
          hint: 'Question words come first',
        ),
        ExerciseQuestion(
          id: '2',
          question: 'Arrange: [is] [name] [My] [John]',
          options: ['My name is John', 'John is my name', 'Is my name John', 'Name is John my'],
          correctIndex: 0,
          explanation: 'My name is John (Subject + verb + complement)',
          hint: 'Start with the subject',
        ),
        ExerciseQuestion(
          id: '3',
          question: 'Arrange: [the] [in] [I] [park] [am]',
          options: ['I am in the park', 'In the park am I', 'The park I am in', 'Am in the park I'],
          correctIndex: 0,
          explanation: 'I am in the park (SVO word order)',
          hint: 'English uses Subject-Verb-Object order',
        ),
      ],
    ),
    Exercise(
      id: '4',
      title: 'Translation - Basic Sentences',
      description: 'Translate Vietnamese sentences to English',
      type: 'translation',
      difficulty: 2,
      duration: 10,
      questions: [
        ExerciseQuestion(
          id: '1',
          question: 'Translate: "Tên tôi là Mai"',
          options: ['My name Mai', 'My name is Mai', 'I am Mai name', 'Mai is name my'],
          correctIndex: 1,
          explanation: 'My name is Mai (subject + verb to be + name)',
          hint: 'Use "My name is" for introduction',
        ),
        ExerciseQuestion(
          id: '2',
          question: 'Translate: "Bạn khỏe không?"',
          options: ['How you are', 'How are you', 'You how are', 'Are how you'],
          correctIndex: 1,
          explanation: 'How are you? (polite greeting)',
          hint: 'This is a common greeting question',
        ),
        ExerciseQuestion(
          id: '3',
          question: 'Translate: "Tôi thích sách"',
          options: ['I like book', 'I like books', 'I likes books', 'I am like books'],
          correctIndex: 1,
          explanation: 'I like books (plural noun in this context)',
          hint: 'Books is plural here',
        ),
      ],
    ),
    Exercise(
      id: '5',
      title: 'Listening Comprehension - Questions',
      description: 'Answer questions based on listening',
      type: 'listening',
      difficulty: 3,
      duration: 12,
      questions: [
        ExerciseQuestion(
          id: '1',
          question: 'What time do you go to school?',
          options: ['7:00 AM', '8:00 AM', '9:00 AM', '10:00 AM'],
          correctIndex: 1,
          explanation: 'The correct answer from the audio is 8:00 AM',
          hint: 'Listen to the time mentioned',
        ),
        ExerciseQuestion(
          id: '2',
          question: 'Where does John work?',
          options: ['At school', 'At home', 'At office', 'At hospital'],
          correctIndex: 2,
          explanation: 'John works at an office',
          hint: 'Identify the workplace',
        ),
      ],
    ),
    Exercise(
      id: '6',
      title: 'Vocabulary - Food & Drinks',
      description: 'Choose the correct English word for food items',
      type: 'vocabulary',
      difficulty: 1,
      duration: 6,
      questions: [
        ExerciseQuestion(
          id: '1',
          question: 'What is "Nước" in English?',
          options: ['Food', 'Water', 'Juice', 'Milk'],
          correctIndex: 1,
          explanation: 'Nước = Water',
          hint: 'It is a common beverage',
        ),
        ExerciseQuestion(
          id: '2',
          question: 'What is "Cơm" in English?',
          options: ['Bread', 'Rice', 'Pasta', 'Soup'],
          correctIndex: 1,
          explanation: 'Cơm = Rice (staple food)',
          hint: 'Vietnamese staple food',
        ),
        ExerciseQuestion(
          id: '3',
          question: 'What is "Cà phê" in English?',
          options: ['Tea', 'Coffee', 'Juice', 'Water'],
          correctIndex: 1,
          explanation: 'Cà phê = Coffee',
          hint: 'Popular morning beverage in Vietnam',
        ),
      ],
    ),
  ];
}