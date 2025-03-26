import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';

import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Ear App',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  static const List<Widget> _widgetOptions = <Widget>[
    SpeechToTextScreen(),
    SignLanguageScreen(),
    EmergencyScreen(),
    LearningModeScreen(),
    TherapyScreen(),
    SocialPlatformScreen(),
    MedicalHistoryScreen(),
    AccessibilityScreen(),
    LanguageScreen(),
    NotificationScreen(),
    VibrationScreen(),
    EmergencyContactScreen(),
    FeedScreen(),
    LeaderboardScreen(),
    ChatScreen(),
    ProfileScreen(),
    GameScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Ear App'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Speech',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gesture),
            label: 'Sign',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency),
            label: 'Emergency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Therapy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Social',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
            padding: EdgeInsets.zero,
            children: [
        const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blue),
        child: Text('My Ear App', style: TextStyle(color: Colors.white, fontSize: 24)),
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Medical History'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 6; // Medical History Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.accessibility),
          title: const Text('Accessibility'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 7; // Accessibility Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 8; // Language Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text('Notifications'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 9; // Notification Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.vibration),
          title: const Text('Vibration'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 10; // Vibration Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.contact_emergency),
          title: const Text('Emergency Contacts'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 11; // Emergency Contacts Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.feed),
          title: const Text('Community Feed'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 12; // Feed Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.leaderboard),
          title: const Text('Leaderboard'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 13; // Leaderboard Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.chat),
          title: const Text('Chat'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 14; // Chat Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 15; // Profile Screen index
            });
          },
        ),
        ListTile(
          leading: const Icon(Icons.games),
          title: const Text('Games'),
          onTap: () {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = 16; // Game Screen index
            });
          },
        ),
        ],
      ),
    ),
    );
  }
}

// Speech to Text Screen
class SpeechToTextScreen extends StatefulWidget {
  const SpeechToTextScreen({super.key});

  @override
  State<SpeechToTextScreen> createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  String _translatedText = '';
  final FlutterTts _flutterTts = FlutterTts();
  double _speechVolume = 1.0;
  double _speechRate = 0.5;
  double _speechPitch = 1.0;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setVolume(_speechVolume);
    await _flutterTts.setSpeechRate(_speechRate);
    await _flutterTts.setPitch(_speechPitch);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Status: $status'),
        onError: (error) => debugPrint('Error: $error'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) => setState(() {
            _text = result.recognizedWords;
            if (result.finalResult) {
              _translateText(_text);
            }
          }),
          listenFor: const Duration(minutes: 5),
          pauseFor: const Duration(seconds: 5),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _translateText(String text) async {
    setState(() {
      _translatedText = "Translated: $text (mock translation)";
    });
  }

  Future<void> _speak() async {
    await _flutterTts.speak(_text);
  }

  Future<void> _speakTranslated() async {
    await _flutterTts.speak(_translatedText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speech to Text & Translation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(_text, style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Translation', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Text(_translatedText.isEmpty ? 'Translation will appear here' : _translatedText),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _speak,
                  child: const Text('Speak Original'),
                ),
                ElevatedButton(
                  onPressed: _speakTranslated,
                  child: const Text('Speak Translated'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text('Volume: ${_speechVolume.toStringAsFixed(1)}'),
                Slider(
                  value: _speechVolume,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() {
                      _speechVolume = value;
                      _flutterTts.setVolume(value);
                    });
                  },
                ),
                Text('Rate: ${_speechRate.toStringAsFixed(1)}'),
                Slider(
                  value: _speechRate,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() {
                      _speechRate = value;
                      _flutterTts.setSpeechRate(value);
                    });
                  },
                ),
                Text('Pitch: ${_speechPitch.toStringAsFixed(1)}'),
                Slider(
                  value: _speechPitch,
                  min: 0.5,
                  max: 2.0,
                  divisions: 15,
                  onChanged: (value) {
                    setState(() {
                      _speechPitch = value;
                      _flutterTts.setPitch(value);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        backgroundColor: _isListening ? Colors.red : Colors.blue,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}

// Sign Language Screen
class SignLanguageScreen extends StatefulWidget {
  const SignLanguageScreen({super.key});

  @override
  State<SignLanguageScreen> createState() => _SignLanguageScreenState();
}

class _SignLanguageScreenState extends State<SignLanguageScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isProcessing = false;
  String _output = '';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium,
      );
      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> _captureImage() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        setState(() => _isProcessing = true);
        final image = await _cameraController!.takePicture();
        // Process the image here
        setState(() {
          _output = 'Sign detected: Sample Output';
          _isProcessing = false;
        });
      } catch (e) {
        debugPrint('Error capturing image: $e');
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Language to Text')),
      body: Column(
        children: [
          if (_isCameraInitialized)
            Expanded(
              child: AspectRatio(
                aspectRatio: _cameraController!.value.aspectRatio,
                child: CameraPreview(_cameraController!),
              ),
            )
          else
            const Expanded(child: Center(child: CircularProgressIndicator())),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _output.isEmpty ? 'Detection results will appear here' : _output,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _captureImage,
                  child: _isProcessing
                      ? const CircularProgressIndicator()
                      : const Text('Capture and Detect'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Emergency Screen
class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final List<String> _emergencyContacts = [];
  bool _isSendingSOS = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final prefs = await _prefs;
    setState(() {
      _emergencyContacts.addAll(prefs.getStringList('emergencyContacts') ?? ['911', '112']);
    });
  }

  Future<void> _saveContacts() async {
    final prefs = await _prefs;
    await prefs.setStringList('emergencyContacts', _emergencyContacts);
  }

  Future<void> sendEmergencySMS(String message) async {
    setState(() => _isSendingSOS = true);
    try {
      for (final contact in _emergencyContacts) {
        final uri = Uri.parse('sms:$contact?body=${Uri.encodeComponent(message)}');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Emergency messages sent!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send messages: $e')),
      );
    } finally {
      setState(() => _isSendingSOS = false);
    }
  }

  void _addContact(String contact) {
    if (contact.trim().isNotEmpty) {
      setState(() => _emergencyContacts.add(contact.trim()));
      _saveContacts();
    }
  }

  void _removeContact(int index) {
    setState(() => _emergencyContacts.removeAt(index));
    _saveContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Mode')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _emergencyContacts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_emergencyContacts[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _removeContact(index),
                    ),
                  );
                },
              ),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Add Emergency Contact',
                suffixIcon: Icon(Icons.add),
              ),
              keyboardType: TextInputType.phone,
              onSubmitted: _addContact,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSendingSOS
                  ? null
                  : () => sendEmergencySMS('EMERGENCY! I need help!'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isSendingSOS
                  ? const CircularProgressIndicator()
                  : const Text('SEND EMERGENCY SOS'),
            ),
          ],
        ),
      ),
    );
  }
}

// Learning Mode Screen
class LearningModeScreen extends StatelessWidget {
  const LearningModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Mode')),
      body: const Center(child: Text('Learning content will be displayed here')),
    );
  }
}

// Therapy Screen
class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Therapy & Speech Training')),
      body: const Center(child: Text('Therapy content will be displayed here')),
    );
  }
}

// Social Platform Screen
class SocialPlatformScreen extends StatelessWidget {
  const SocialPlatformScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Chat')),
      body: const Center(child: Text('Community content will be displayed here')),
    );
  }
}

// Medical History Screen
class MedicalHistoryScreen extends StatelessWidget {
  const MedicalHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medical History')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('medical_records')
            .where('userId', isEqualTo: 'current_user_id')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final record = snapshot.data!.docs[index];
              return ExpansionTile(
                title: Text(
                    'Record ${index + 1} - ${record['timestamp']?.toDate().toString() ?? 'Unknown'}'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Symptoms: ${record['symptoms']}'),
                        const SizedBox(height: 8),
                        if (record['notes'] != null)
                          Text('Notes: ${record['notes']}'),
                        const SizedBox(height: 8),
                        if (record['doctorResponse'] != null)
                          Text('Doctor Response: ${record['doctorResponse']}'),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// Accessibility Screen
class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  double _fontSize = 16.0;
  bool _highContrast = false;
  bool _screenReader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accessibility Options')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Font Size', style: TextStyle(fontSize: _fontSize)),
            Slider(
              value: _fontSize,
              min: 12.0,
              max: 24.0,
              divisions: 6,
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('High Contrast Mode'),
              value: _highContrast,
              onChanged: (value) {
                setState(() {
                  _highContrast = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Screen Reader Mode'),
              value: _screenReader,
              onChanged: (value) {
                setState(() {
                  _screenReader = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: _fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is how text will appear with your current settings.',
                      style: TextStyle(fontSize: _fontSize),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Language Screen
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English';
  final List<String> _supportedLanguages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Hindi'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Language Preferences')),
      body: Center(
        child: DropdownButton<String>(
          value: _selectedLanguage,
          onChanged: (String? newValue) {
            setState(() {
              _selectedLanguage = newValue!;
            });
          },
          items: _supportedLanguages
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Notification Screen
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  bool _lessonReminders = true;
  bool _therapyReminders = true;
  bool _communityUpdates = true;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleDailyReminder() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'daily_reminder',
      'Daily Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Practice Time!',
      'Remember to practice your sign language today',
      RepeatInterval.daily,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Preferences')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Lesson Reminders'),
              value: _lessonReminders,
              onChanged: (value) {
                setState(() {
                  _lessonReminders = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Therapy Session Reminders'),
              value: _therapyReminders,
              onChanged: (value) {
                setState(() {
                  _therapyReminders = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Community Updates'),
              value: _communityUpdates,
              onChanged: (value) {
                setState(() {
                  _communityUpdates = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scheduleDailyReminder,
              child: const Text('Enable Daily Practice Reminder'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                const AndroidNotificationDetails androidPlatformChannelSpecifics =
                AndroidNotificationDetails(
                  'test_notification',
                  'Test Notifications',
                  importance: Importance.max,
                  priority: Priority.high,
                );
                const NotificationDetails platformChannelSpecifics =
                NotificationDetails(android: androidPlatformChannelSpecifics);
                await flutterLocalNotificationsPlugin.show(
                  1,
                  'Test Notification',
                  'This is a test notification from My Ear App',
                  platformChannelSpecifics,
                );
              },
              child: const Text('Send Test Notification'),
            ),
          ],
        ),
      ),
    );
  }
}

// Vibration Screen
class VibrationScreen extends StatefulWidget {
  const VibrationScreen({super.key});

  @override
  State<VibrationScreen> createState() => _VibrationScreenState();
}

class _VibrationScreenState extends State<VibrationScreen> {
  bool _vibrationEnabled = true;
  String _vibrationPattern = 'default';
  final List<String> _patterns = [
    'default',
    'short',
    'long',
    'sos',
    'heartbeat'
  ];

  Future<void> _testVibration() async {
    if (!_vibrationEnabled) return;

    switch (_vibrationPattern) {
      case 'short':
        await Vibration.vibrate(duration: 100);
        break;
      case 'long':
        await Vibration.vibrate(duration: 500);
        break;
      case 'sos':
        await Vibration.vibrate(pattern: [100, 100, 100, 300, 100, 100, 100]);
        break;
      case 'heartbeat':
        await Vibration.vibrate(pattern: [100, 200, 100, 500]);
        break;
      default:
        await Vibration.vibrate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vibration Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Enable Vibration'),
              value: _vibrationEnabled,
              onChanged: (value) {
                setState(() {
                  _vibrationEnabled = value;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text('Vibration Pattern:'),
            Column(
              children: _patterns.map((pattern) {
                return RadioListTile<String>(
                  title: Text(pattern),
                  value: pattern,
                  groupValue: _vibrationPattern,
                  onChanged: (String? value) {
                    setState(() {
                      _vibrationPattern = value!;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testVibration,
              child: const Text('Test Vibration'),
            ),
          ],
        ),
      ),
    );
  }
}

// Emergency Contact Screen
class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({super.key});

  @override
  State<EmergencyContactScreen> createState() => _EmergencyContactScreenState();
}

class _EmergencyContactScreenState extends State<EmergencyContactScreen> {
  final List<String> _contacts = [];
  final TextEditingController _contactController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final prefs = await _prefs;
    setState(() {
      _contacts.addAll(prefs.getStringList('emergencyContacts') ?? []);
    });
  }

  Future<void> _saveContacts() async {
    final prefs = await _prefs;
    await prefs.setStringList('emergencyContacts', _contacts);
  }

  void _addContact() {
    if (_contactController.text.trim().isNotEmpty) {
      setState(() {
        _contacts.add(_contactController.text.trim());
        _contactController.clear();
      });
      _saveContacts();
    }
  }

  void _removeContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
    _saveContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Contacts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _contactController,
                    decoration: const InputDecoration(
                      labelText: 'Add Emergency Contact',
                      hintText: 'Enter phone number',
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addContact,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_contacts[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeContact(index),
                      ),
                      onTap: () async {
                        final uri = Uri.parse('tel:${_contacts[index]}');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Feed Screen
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final TextEditingController _postController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _createPost() async {
    if (_postController.text.trim().isEmpty && _imageFile == null) return;

    try {
      await FirebaseFirestore.instance.collection('posts').add({
        'text': _postController.text,
        'userId': 'current_user_id',
        'timestamp': FieldValue.serverTimestamp(),
        'imageUrl': _imageFile != null ? 'placeholder_url' : null,
      });

      _postController.clear();
      setState(() {
        _imageFile = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post created successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Feed')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _postController,
                      decoration: const InputDecoration(
                        hintText: 'Share something with the community...',
                        border: InputBorder.none,
                      ),
                      maxLines: 3,
                    ),
                    if (_imageFile != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.file(_imageFile!),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.image),
                          onPressed: _pickImage,
                        ),
                        ElevatedButton(
                          onPressed: _createPost,
                          child: const Text('Post'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(post['userId']),
                            subtitle: Text(
                              post['timestamp']?.toDate().toString() ?? '',
                            ),
                          ),
                          if (post['text'] != null && post['text'].isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              child: Text(post['text']),
                            ),
                          if (post['imageUrl'] != null)
                            Image.network(post['imageUrl']),
                          OverflowBar(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Leaderboard Screen
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .orderBy('score', descending: true)
            .limit(20)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final user = snapshot.data!.docs[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(user['name'] ?? 'Anonymous'),
                trailing: Text('${user['score'] ?? 0} points'),
              );
            },
          );
        },
      ),
    );
  }
}

// Chat Screen
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('chats').add({
        'text': text,
        'sender': 'current_user_id',
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sending message: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy('timestamp', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data!.docs[index];
                    final isMe = message['sender'] == 'current_user_id';
                    return Align(
                      alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.blue[100]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['text'],
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              message['timestamp']
                                  ?.toDate()
                                  .toString()
                                  .substring(11, 16) ??
                                  '',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: sendMessage,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Profile Screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    _nameController.text = 'Current User';
    _bioController.text = 'Sign language learner';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const AssetImage('assets/default_profile.png')
                as ImageProvider,
                child: _profileImage == null
                    ? const Icon(Icons.camera_alt, size: 30)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save Profile'),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Achievements', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildAchievement('Beginner', Icons.star, Colors.yellow),
                _buildAchievement('5 Lessons', Icons.school, Colors.blue),
                _buildAchievement('Active', Icons.forum, Colors.green),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text('Stats', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('Lessons', '5', Icons.school),
                _buildStat('Friends', '12', Icons.people),
                _buildStat('Streak', '3', Icons.local_fire_department),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievement(String title, IconData icon, Color color) {
    return Chip(
      avatar: Icon(icon, color: color),
      label: Text(title),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 18)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// Game Screen
class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Games')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignLanguageQuiz()),
                );
              },
              child: const Text('Sign Language Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MemoryGame()),
                );
              },
              child: const Text('Memory Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MatchingGame()),
                );
              },
              child: const Text('Matching Game'),
            ),
          ],
        ),
      ),
    );
  }
}

// Sign Language Quiz
class SignLanguageQuiz extends StatefulWidget {
  const SignLanguageQuiz({super.key});

  @override
  State<SignLanguageQuiz> createState() => _SignLanguageQuizState();
}

class _SignLanguageQuizState extends State<SignLanguageQuiz> {
  int _score = 0;
  int _currentQuestionIndex = 0;
  bool _showResult = false;
  bool _isCorrect = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the sign for "A"?',
      'image': 'assets/sign_a.jpg',
      'options': ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
      'correctAnswer': 0,
    },
    {
      'question': 'What is the sign for "Thank You"?',
      'image': 'assets/sign_thankyou.jpg',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
      'correctAnswer': 2,
    },
  ];

  void _answerQuestion(int selectedIndex) {
    setState(() {
      _showResult = true;
      _isCorrect = selectedIndex == _questions[_currentQuestionIndex]['correctAnswer'];
      if (_isCorrect) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _showResult = false;
          if (_currentQuestionIndex < _questions.length - 1) {
            _currentQuestionIndex++;
          } else {
            _saveScore();
          }
        });
      }
    });
  }

  Future<void> _saveScore() async {
    try {
      await FirebaseFirestore.instance.collection('quiz_scores').add({
        'userId': 'current_user_id',
        'score': _score,
        'total': _questions.length,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error saving score: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Language Quiz')),
      body: _currentQuestionIndex < _questions.length
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
            ),
            const SizedBox(height: 16),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (_questions[_currentQuestionIndex]['image'] != null)
              Expanded(
                child: Image.asset(
                  _questions[_currentQuestionIndex]['image'],
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(height: 16),
            ...(_questions[_currentQuestionIndex]['options']
            as List<String>)
                .asMap()
                .entries
                .map((entry) {
              final index = entry.key;
              final option = entry.value;
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: ElevatedButton(
              onPressed: _showResult
              ? null
                  : () => _answerQuestion(index),
              style: ElevatedButton.styleFrom(
              backgroundColor: _showResult
              ? (index ==
              _questions[_currentQuestionIndex]
              ['correctAnswer']
              ? Colors.green
                  : (index ==
              _questions[_currentQuestionIndex]
              ['correctAnswer'] &&
              _isCorrect
              ? Colors.green
                  : (index ==
              _questions[_currentQuestionIndex]
              ['correctAnswer'] &&
              !_isCorrect
              ? Colors.red
                  : null))
                  : null,
              foregroundColor: _showResult ? Colors.white : null,
              ),
              child: Text(option),
              ),
              );
            }).toList(),
            if (_showResult)
              Text(
                _isCorrect ? 'Correct!' : 'Wrong!',
                style: TextStyle(
                  color: _isCorrect ? Colors.green : Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            Text(
              'Your score: $_score/${_questions.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to Games'),
            ),
          ],
        ),
      ),
    );
  }
}

// Memory Game
class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final List<String> _cardValues = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  late List<String> _cards;
  late List<bool> _cardFlips;
  int _firstCardIndex = -1;
  int _secondCardIndex = -1;
  bool _canFlip = true;
  int _matchedPairs = 0;
  int _attempts = 0;
  bool _gameWon = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _cards = [..._cardValues, ..._cardValues]..shuffle();
    _cardFlips = List<bool>.filled(_cards.length, false);
    _firstCardIndex = -1;
    _secondCardIndex = -1;
    _canFlip = true;
    _matchedPairs = 0;
    _attempts = 0;
    _gameWon = false;
  }

  void _flipCard(int index) {
    if (!_canFlip || _cardFlips[index] || index == _firstCardIndex) {
      return;
    }

    setState(() {
      _cardFlips[index] = true;
    });

    if (_firstCardIndex == -1) {
      _firstCardIndex = index;
    } else {
      _secondCardIndex = index;
      _canFlip = false;
      _attempts++;

      if (_cards[_firstCardIndex] == _cards[_secondCardIndex]) {
        _matchedPairs++;
        if (_matchedPairs == _cardValues.length) {
          _gameWon = true;
          _saveScore();
        }
        _firstCardIndex = -1;
        _secondCardIndex = -1;
        _canFlip = true;
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            setState(() {
              _cardFlips[_firstCardIndex] = false;
              _cardFlips[_secondCardIndex] = false;
              _firstCardIndex = -1;
              _secondCardIndex = -1;
              _canFlip = true;
            });
          }
        });
      }
    }
  }

  Future<void> _saveScore() async {
    try {
      await FirebaseFirestore.instance.collection('memory_scores').add({
        'userId': 'current_user_id',
        'attempts': _attempts,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      debugPrint('Error saving score: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Game')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Attempts: $_attempts'),
                Text('Pairs: $_matchedPairs/${_cardValues.length}'),
              ],
            ),
          ),
          if (_gameWon)
            AlertDialog(
              title: const Text('Congratulations!'),
              content: Text('You won in $_attempts attempts!'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _initializeGame();
                    });
                  },
                  child: const Text('Play Again'),
                ),
              ],
            ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
              ),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _flipCard(index),
                  child: Card(
                    margin: const EdgeInsets.all(4.0),
                    color: _cardFlips[index] ? Colors.white : Colors.blue,
                    child: Center(
                      child: _cardFlips[index]
                          ? Text(
                        _cards[index],
                        style: const TextStyle(fontSize: 24),
                      )
                          : const Icon(Icons.question_mark, size: 24),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _initializeGame,
              child: const Text('Restart Game'),
            ),
          ),
        ],
      ),
    );
  }
}

// Matching Game
class MatchingGame extends StatefulWidget {
  const MatchingGame({super.key});

  @override
  State<MatchingGame> createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {
  final List<Map<String, dynamic>> _items = [
    {'sign': 'A', 'word': 'Apple', 'image': 'assets/apple.jpg'},
    {'sign': 'B', 'word': 'Ball', 'image': 'assets/ball.jpg'},
    {'sign': 'C', 'word': 'Cat', 'image': 'assets/cat.jpg'},
    {'sign': 'D', 'word': 'Dog', 'image': 'assets/dog.jpg'},
  ];
  late List<Map<String, dynamic>> _shuffledItems;
  int? _selectedIndex;
  int _matchedPairs = 0;
  bool _gameWon = false;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    _shuffledItems = [..._items]..shuffle();
    _selectedIndex = null;
    _matchedPairs = 0;
    _gameWon = false;
  }

  void _selectItem(int index) {
    if (_selectedIndex == null) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      if (_shuffledItems[_selectedIndex!]['sign'] ==
          _shuffledItems[index]['sign']) {
        setState(() {
          _matchedPairs++;
          if (_matchedPairs == _items.length) {
            _gameWon = true;
          }
          _selectedIndex = null;
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _selectedIndex = null;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matching Game')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Match the sign to the correct word and image',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          if (_gameWon)
            AlertDialog(
              title: const Text('Congratulations!'),
              content: const Text('You matched all pairs correctly!'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _initializeGame();
                    });
                  },
                  child: const Text('Play Again'),
                ),
              ],
            ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: _shuffledItems.length,
              itemBuilder: (context, index) {
                final item = _shuffledItems[index];
                final isSelected = _selectedIndex == index;
                final isSign = item['sign'] != null;

                return GestureDetector(
                  onTap: () => _selectItem(index),
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    color: isSelected ? Colors.blue[100] : Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSign)
                            Text(
                              item['sign'],
                              style: const TextStyle(fontSize: 40),
                            )
                          else if (item['image'] != null)
                            Image.asset(
                              item['image'],
                              height: 60,
                            ),
                          if (!isSign && item['word'] != null)
                            Text(
                              item['word'],
                              style: const TextStyle(fontSize: 20),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _initializeGame,
              child: const Text('Restart Game'),
            ),
          ),
        ],
      ),
    );
  }
}