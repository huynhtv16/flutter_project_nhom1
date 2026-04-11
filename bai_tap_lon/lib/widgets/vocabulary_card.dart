import 'package:flutter/material.dart';
import '../models/vocabulary.dart';
import '../services/tts_service.dart';

class VocabularyCard extends StatefulWidget {
  final Vocabulary vocabulary;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const VocabularyCard({
    Key? key,
    required this.vocabulary,
    required this.isFavorite,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _VocabularyCardState createState() => _VocabularyCardState();
}

class _VocabularyCardState extends State<VocabularyCard>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onCardPressed() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onCardPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image/Icon Header with Gradient
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: _getGradientColors(),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Background Icon (smaller, transparent)
                      Positioned(
                        right: -20,
                        top: -20,
                        child: Icon(
                          _getIconData(),
                          size: 180,
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      // Main Icon (centered, large)
                      Center(
                        child: Icon(
                          _getIconData(),
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Word & Favorite Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.vocabulary.word,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _getCategory(),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ScaleTransition(
                          scale: Tween<double>(begin: 1.0, end: 1.2)
                              .animate(_animationController),
                          child: IconButton(
                            icon: Icon(
                              widget.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: widget.isFavorite ? Colors.red : Colors.grey,
                              size: 28,
                            ),
                            onPressed: () {
                              widget.onFavoriteToggle();
                              _onCardPressed();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Phonetic
                    Row(
                      children: [
                        Icon(Icons.volume_up, size: 16, color: Colors.orange),
                        const SizedBox(width: 6),
                        Text(
                          widget.vocabulary.phonetic,
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Meaning with Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.translate,
                              size: 18, color: Colors.blue.shade600),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.vocabulary.meaning,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Example with Icon
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.article,
                              size: 18, color: Colors.green.shade600),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.vocabulary.example,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Pronunciation Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _playPronunciation,
                        icon: Icon(_isPlaying ? Icons.stop : Icons.volume_up),
                        label: Text(_isPlaying ? 'Stopping...' : 'Listen'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _playPronunciation() async {
    if (_isPlaying) {
      await TtsService.stop();
      setState(() => _isPlaying = false);
    } else {
      setState(() => _isPlaying = true);
      await TtsService.speak(widget.vocabulary.word);
      setState(() => _isPlaying = false);
    }
  }

  String _getCategory() {
    final word = widget.vocabulary.word.toLowerCase();

    if (['hello', 'goodbye', 'thank', 'please', 'sorry', 'yes', 'no']
        .any((w) => word.contains(w))) return 'Polite';
    if (['cat', 'dog', 'bird', 'fish', 'elephant', 'lion']
        .any((w) => word.contains(w))) return 'Animals';
    if (['apple', 'banana', 'orange', 'water', 'coffee', 'tea', 'rice', 'bread']
        .any((w) => word.contains(w))) return 'Food & Drink';
    if (['red', 'blue', 'green', 'yellow', 'black', 'white']
        .any((w) => word.contains(w))) return 'Colors';
    if (['mother', 'father', 'sister', 'brother', 'grandmother', 'grandfather']
        .any((w) => word.contains(w))) return 'Family';
    if (['house', 'room', 'kitchen', 'bedroom', 'bathroom', 'door']
        .any((w) => word.contains(w))) return 'House';
    if (['school', 'book', 'teacher', 'student', 'pen', 'pencil']
        .any((w) => word.contains(w))) return 'School';
    if (['sun', 'moon', 'star', 'tree', 'flower', 'water']
        .any((w) => word.contains(w))) return 'Nature';
    if (['car', 'bus', 'bicycle', 'train', 'airplane']
        .any((w) => word.contains(w))) return 'Transport';
    if (['happy', 'sad', 'angry', 'tired', 'love']
        .any((w) => word.contains(w))) return 'Emotions';
    if (['play', 'dance', 'sing', 'read', 'write', 'run']
        .any((w) => word.contains(w))) return 'Activities';

    return 'General';
  }

  IconData _getIconData() {
    final word = widget.vocabulary.word.toLowerCase();

    if (word.contains('hello') || word.contains('goodbye') || word.contains('hi'))
      return Icons.waving_hand;
    if (word.contains('thank') || word.contains('please') ||
        word.contains('sorry')) return Icons.handshake;
    if (word.contains('apple') || word.contains('banana') ||
        word.contains('orange')) return Icons.apple;
    if (word.contains('book') || word.contains('read') ||
        word.contains('write') || word.contains('pen') ||
        word.contains('pencil')) return Icons.book;
    if (word.contains('cat') || word.contains('dog') ||
        word.contains('bird') || word.contains('fish') ||
        word.contains('elephant') || word.contains('lion')) return Icons.pets;
    if (word.contains('house') ||
        word.contains('home') ||
        word.contains('room') ||
        word.contains('kitchen') ||
        word.contains('bedroom') ||
        word.contains('bathroom')) return Icons.home;
    if (word.contains('school') || word.contains('teacher') ||
        word.contains('student')) return Icons.school;
    if (word.contains('music') || word.contains('sing') ||
        word.contains('piano') || word.contains('song')) return Icons.music_note;
    if (word.contains('sun') || word.contains('moon') ||
        word.contains('star')) return Icons.wb_sunny;
    if (word.contains('car') || word.contains('bus') ||
        word.contains('bicycle') || word.contains('train')) return Icons.directions_car;
    if (word.contains('airplane')) return Icons.flight;
    if (word.contains('phone') || word.contains('call') ||
        word.contains('mobile')) return Icons.phone;
    if (word.contains('computer') || word.contains('tech') ||
        word.contains('digital')) return Icons.computer;
    if (word.contains('tree') || word.contains('plant') ||
        word.contains('nature') || word.contains('flower')) return Icons.park;
    if (word.contains('water') || word.contains('ocean') ||
        word.contains('swim')) return Icons.water_drop;
    if (word.contains('heart') || word.contains('love'))
      return Icons.favorite;
    if (word.contains('smile') ||
        word.contains('happy') ||
        word.contains('laugh')) return Icons.sentiment_very_satisfied;
    if (word.contains('sad') || word.contains('cry') ||
        word.contains('angry')) return Icons.sentiment_very_dissatisfied;
    if (word.contains('sport') ||
        word.contains('play') ||
        word.contains('ball') ||
        word.contains('dance') ||
        word.contains('run')) return Icons.sports_soccer;
    if (word.contains('coffee') || word.contains('tea') ||
        word.contains('drink') || word.contains('water')) return Icons.coffee;
    if (word.contains('work') || word.contains('office') ||
        word.contains('job')) return Icons.work;
    if (word.contains('mother') || word.contains('father') ||
        word.contains('grandmother') || word.contains('grandfather') ||
        word.contains('sister') || word.contains('brother')) return Icons.person;
    if (word.contains('red') || word.contains('blue') ||
        word.contains('green') || word.contains('yellow') ||
        word.contains('black') || word.contains('white')) return Icons.palette;

    return Icons.lightbulb;
  }

  List<Color> _getGradientColors() {
    final word = widget.vocabulary.word.toLowerCase();

    if (word.contains('hello') || word.contains('goodbye'))
      return [Colors.blue.shade400, Colors.blue.shade700];
    if (word.contains('apple'))
      return [Colors.red.shade300, Colors.red.shade600];
    if (word.contains('banana'))
      return [Colors.yellow.shade300, Colors.yellow.shade600];
    if (word.contains('book'))
      return [Colors.orange.shade300, Colors.orange.shade600];
    if (word.contains('cat') ||
        word.contains('dog') ||
        word.contains('pet') ||
        word.contains('bird') ||
        word.contains('fish')) return [Colors.purple.shade300, Colors.purple.shade600];
    if (word.contains('house') ||
        word.contains('home') ||
        word.contains('room')) return [Colors.brown.shade300, Colors.brown.shade600];
    if (word.contains('school'))
      return [Colors.indigo.shade300, Colors.indigo.shade600];
    if (word.contains('music') || word.contains('sing'))
      return [Colors.pink.shade300, Colors.pink.shade600];
    if (word.contains('sun') || word.contains('star'))
      return [Colors.yellow.shade300, Colors.yellow.shade600];
    if (word.contains('water') || word.contains('ocean'))
      return [Colors.cyan.shade300, Colors.cyan.shade700];
    if (word.contains('heart') || word.contains('love'))
      return [Colors.red.shade300, Colors.pink.shade600];
    if (word.contains('happy'))
      return [Colors.lime.shade300, Colors.green.shade600];
    if (word.contains('sad'))
      return [Colors.grey.shade400, Colors.grey.shade700];
    if (word.contains('sport') || word.contains('play') ||
        word.contains('dance') || word.contains('run'))
      return [Colors.teal.shade300, Colors.teal.shade600];
    if (word.contains('coffee'))
      return [Colors.brown.shade200, Colors.brown.shade700];
    if (word.contains('tree') ||
        word.contains('plant') ||
        word.contains('flower')) return [Colors.green.shade300, Colors.green.shade600];
    if (word.contains('car') || word.contains('bus') ||
        word.contains('bicycle') || word.contains('train'))
      return [Colors.deepOrange.shade300, Colors.deepOrange.shade600];
    if (word.contains('family') || word.contains('mother') ||
        word.contains('father')) return [Colors.amber.shade300, Colors.amber.shade600];
    if (word.contains('red'))
      return [Colors.red.shade300, Colors.red.shade600];
    if (word.contains('blue'))
      return [Colors.blue.shade300, Colors.blue.shade600];
    if (word.contains('green'))
      return [Colors.green.shade300, Colors.green.shade600];
    if (word.contains('yellow'))
      return [Colors.yellow.shade300, Colors.yellow.shade600];
    if (word.contains('black'))
      return [Colors.grey.shade700, Colors.grey.shade900];
    if (word.contains('white'))
      return [Colors.grey.shade200, Colors.grey.shade400];

    return [Colors.grey.shade400, Colors.grey.shade700];
  }
}