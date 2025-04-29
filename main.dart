import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// ignore: unused_import
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// ignore: unused_import
import 'package:flutter_cube/flutter_cube.dart';
import 'package:diacritic/diacritic.dart';

void main() {
  runApp(const EduVivoApp());
}

class EduVivoApp extends StatelessWidget {
  const EduVivoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduVivo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    const storage = FlutterSecureStorage();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: 350,
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'EduVivo',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple[900],
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Όνομα Χρήστη',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Κωδικός Πρόσβασης',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[800],
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    // Έλεγχος συνδεσιμότητας
                    var connectivityResult =
                        await (Connectivity().checkConnectivity());
                    if (connectivityResult == ConnectivityResult.none) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Δεν έχετε σύνδεση στο διαδίκτυο.')),
                      );
                      return;
                    }

                    // Αποθήκευση κωδικού (για σκοπούς επίδειξης)
                    await storage.write(
                        key: "username", value: usernameController.text);
                    await storage.write(
                        key: "password", value: passwordController.text);

                    if (usernameController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Παρακαλώ συμπληρώστε όλα τα πεδία.')),
                      );
                    }
                  },
                  child: const Text('Σύνδεση'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const WelcomePage(),
    const DepartmentPage(),
    const LibraryPage(),
    const MessagingPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EduVivo'),
        backgroundColor: Colors.deepPurple[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.book, color: Colors.white),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.library_books, color: Colors.white),
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.message, color: Colors.white),
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              setState(() {
                _selectedIndex = 4;
              });
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      // Χρησιμοποιούμε SingleChildScrollView για scrolling
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Καλωσορίσατε στο EduVivo!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Η εφαρμογή EduVivo είναι μια εκπαιδευτική πλατφόρμα που στοχεύει στην παροχή μιας διαδραστικής και ευχάριστης μαθησιακής εμπειρίας.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Μέσω αυτής της εφαρμογής, μπορείτε να:',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                '- Έχετε πρόσβαση σε διάφορα μαθήματα και τμήματα.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '- Συμμετέχετε σε online συζητήσεις με καθηγητές και άλλους φοιτητές.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '- Εξερευνήσετε εκπαιδευτικό υλικό από την βιβλιοθήκη μας.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Ελπίζουμε να απολαύσετε την εμπειρία σας στο EduVivo!',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Βιβλιοθήκη περιεχομένου',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MessagingPageState createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final List<Map<String, String>> _messages = [
    {"sender": "teacher", "text": "Καλησπέρα! Πώς μπορώ να βοηθήσω σήμερα;"},
    {
      "sender": "student",
      "text": "Γεια σας! Έχω μια απορία σχετικά με την εργασία..."
    },
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({
          "sender": "student",
          "text": text,
        });
      });
      _messageController.clear();

      // Προσομοίωση απάντησης από τον "καθηγητή"
      Future.delayed(const Duration(seconds: 1), () {
        String teacherResponse = _generateTeacherResponse(text);
        setState(() {
          _messages.add({
            "sender": "teacher",
            "text": teacherResponse,
          });
        });
      });
    }
  }

  // Συνάρτηση για την αυτόματη απάντηση του καθηγητή
  String _generateTeacherResponse(String studentMessage) {
    String message = removeDiacritics(studentMessage.toLowerCase());

    // Εργασία / Δουλειά
    if (message.contains('εργασία') ||
        message.contains('δουλειά') ||
        message.contains('πτυχιακή')) {
      return "Η εργασία σου φαίνεται δύσκολη; Πες μου ποιο κομμάτι σε δυσκολεύει και θα σε βοηθήσω.";
    }
    // Βοήθεια
    else if (message.contains('βοήθεια') ||
        message.contains('χρειάζομαι βοήθεια') ||
        message.contains('πώς να το κάνω')) {
      return "Ποιο θέμα χρειάζεσαι βοήθεια; Μπορώ να σου εξηγήσω πιο αναλυτικά ή να σου δώσω παραδείγματα.";
    }
    // Προθεσμία / Deadline
    else if (message.contains('προθεσμία') ||
        message.contains('deadline') ||
        message.contains('πότε είναι η προθεσμία')) {
      return "Η προθεσμία για την εργασία είναι στις 30 του μήνα. Αν έχεις κάποιες απορίες ή δυσκολεύεσαι, ας το δούμε μαζί.";
    }
    // Μαθήματα / Τι να μελετήσω
    else if (message.contains('μάθημα') ||
        message.contains('course') ||
        message.contains('τι να μελετήσω')) {
      return "Ποιο μάθημα χρειάζεσαι βοήθεια; Πες μου και θα σε καθοδηγήσω στις ασκήσεις ή τη θεωρία.";
    }
    // Δοκιμή / Εξετάσεις
    else if (message.contains('δοκιμή') ||
        message.contains('test') ||
        message.contains('θα κάνω εξετάσεις')) {
      return "Αν πρόκειται να κάνεις κάποια δοκιμασία, πες μου ποιο κομμάτι θέλεις να επαναλάβεις, να το δούμε μαζί.";
    }
    // Εκπαίδευση / Μάθηση
    else if (message.contains('εκπαίδευση') ||
        message.contains('learning') ||
        message.contains('θέλω να μάθω')) {
      return "Η εκπαίδευση είναι σημαντική για την πρόοδό σου. Τι ακριβώς θες να μάθεις ή να εξασκηθείς περισσότερο;";
    }
    // Συμβουλή για οργάνωση
    else if (message.contains('συμβουλή') ||
        message.contains('συμβουλή για εργασία') ||
        message.contains('πώς να οργανωθώ')) {
      return "Η καλύτερη συμβουλή που μπορώ να σου δώσω είναι να οργανώσεις τον χρόνο σου και να δουλέψεις σταδιακά.";
    }
    // Πρόβλημα / Δυσκολία
    else if (message.contains('πρόβλημα') ||
        message.contains('difficulty') ||
        message.contains('δεν καταλαβαίνω')) {
      return "Ποιο είναι το πρόβλημά σου; Εξήγησέ μου για να δούμε πώς θα το λύσουμε.";
    }
    // Ανατροφοδότηση / Σχόλια
    else if (message.contains('ανατροφοδότηση') ||
        message.contains('feedback') ||
        message.contains('σχόλια για εργασία')) {
      return "Θες να μιλήσουμε για την ανατροφοδότηση της εργασίας σου; Πες μου τι ακριβώς σε απασχολεί.";
    }
    // Άγνωστο μήνυμα
    else {
      return "Πες μου περισσότερα για το θέμα ή την απορία σου, και θα προσπαθήσω να σε βοηθήσω με τον καλύτερο τρόπο.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Μηνύματα με τον Καθηγητή'),
        backgroundColor: Colors.deepPurple[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isTeacher = message["sender"] == "teacher";

                return Align(
                  alignment:
                      isTeacher ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isTeacher
                          ? Colors.deepPurple[50]
                          : Colors.deepPurple[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message["text"] ?? '',
                      style: TextStyle(
                        color: isTeacher
                            ? Colors.deepPurple[900]
                            : Colors.deepPurple[800],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: "Πληκτρολόγησε το μήνυμά σου...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String _username = '';
  String _phone = '';
  String _address = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Φορτώνουμε τα δεδομένα από το secure storage
  Future<void> _loadUserData() async {
    String? username = await _storage.read(key: 'username');
    String? phone = await _storage.read(key: 'phone');
    String? address = await _storage.read(key: 'address');

    setState(() {
      _username = username ?? '';
      _phone = phone ?? '';
      _address = address ?? '';
    });
  }

  // Ενημερώνουμε τα δεδομένα στο secure storage
  Future<void> _updateUserData(String phone, String address) async {
    await _storage.write(key: 'phone', value: phone);
    await _storage.write(key: 'address', value: address);
    _loadUserData(); // Επαναφόρτωση των δεδομένων
  }

  // Αποσύνδεση και καθαρισμός δεδομένων
  Future<void> _logout() async {
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'phone');
    await _storage.delete(key: 'address');
    // Επιστροφή στην οθόνη σύνδεσης
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController =
        TextEditingController(text: _phone);
    final TextEditingController addressController =
        TextEditingController(text: _address);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Προφίλ Χρήστη'),
        backgroundColor: Colors.deepPurple[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Όνομα Χρήστη: $_username',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Τηλέφωνο',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Διεύθυνση',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ενημέρωση των πληροφοριών στο secure storage
                _updateUserData(phoneController.text, addressController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Οι πληροφορίες ενημερώθηκαν!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[000],
              ),
              child: const Text('Αποθήκευση Πληροφοριών'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout, // Κλήση της συνάρτησης αποσύνδεσης
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[000],
              ),
              child: const Text('Αποσύνδεση'),
            ),
          ],
        ),
      ),
    );
  }
}

class DepartmentPage extends StatelessWidget {
  const DepartmentPage({super.key});

  static const List<String> departments = [
    'Τμήμα Μηχανικών Πληροφορικής',
    'Τμήμα Μηχανολόγων Μηχανικών',
    'Τμήμα Πολιτικών Μηχανικών',
    'Τμήμα Υγείας',
    'Τμήμα Καλών Τεχνών'
  ];

  static const Map<String, List<Map<String, String>>> courses = {
    'Τμήμα Μηχανικών Πληροφορικής': [
      {
        'title': 'Εισαγωγή στην Πληροφορική',
        'description': 'Μάθημα για βασικές αρχές πληροφορικής.',
        'image': 'assets/images/info_intro.png'
      },
      {
        'title': 'Δομές Δεδομένων',
        'description': 'Ανάλυση δομών αποθήκευσης δεδομένων.',
        'image': 'assets/images/data_structures.png'
      },
    ],
    'Τμήμα Μηχανολόγων Μηχανικών': [
      {
        'title': 'Μηχανική Υλικών',
        'description': 'Ιδιότητες και εφαρμογές υλικών.',
        'image': 'assets/images/pliroforiki-1 (1).png'
      },
    ],
    'Τμήμα Πολιτικών Μηχανικών': [
      {
        'title': 'Υδραυλική',
        'description': 'Μελέτη ρευστών και εφαρμογών.',
        'image': 'assets/images/14715172841270017254.png'
      },
    ],
    'Τμήμα Υγείας': [
      {
        'title': 'Καρδιολογία',
        'description': 'Μελέτη καρδιολογικών παθήσεων .',
        'image': 'assets/images/kardia.png',
        '3d_model': 'assets/models/realistic_human_heart.glb' // Το 3D μοντέλο
      },
    ],
    'Τμήμα Καλών Τεχνών': [
      {
        'title': 'Γλυπτική',
        'description': 'Η Τέχνη του Πηλού .',
        'image': 'assets/images/pilos.png'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Τμήματα'),
        backgroundColor: Colors.deepPurple[800],
      ),
      body: ListView.builder(
        itemCount: departments.length,
        itemBuilder: (context, index) {
          String department = departments[index];
          return ListTile(
            title: Text(
              department,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // When a department is tapped, navigate to the courses for that department
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CoursePage(department: department),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CoursePage extends StatelessWidget {
  final String department;

  const CoursePage({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    // Get courses for the selected department
    List<Map<String, String>> departmentCourses =
        DepartmentPage.courses[department] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(department),
        backgroundColor: Colors.deepPurple[800],
      ),
      body: ListView.builder(
        itemCount: departmentCourses.length,
        itemBuilder: (context, index) {
          var course = departmentCourses[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: course['image'] != null
                  ? Image.asset(course['image']!)
                  : const Icon(Icons.error),
              title: Text(course['title'] ?? ''),
              subtitle: Text(course['description'] ?? ''),
              onTap: () {
                // Navigate to the CourseNotesPage when a course is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseNotesPage(
                      courseTitle: course['title'] ?? '',
                      notes: '', // Pass any saved notes here
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CourseNotesPage extends StatefulWidget {
  final String courseTitle;
  final String notes;

  const CourseNotesPage(
      {super.key, required this.courseTitle, required this.notes});

  @override
  CourseNotesPageState createState() => CourseNotesPageState();
}

class CourseNotesPageState extends State<CourseNotesPage> {
  late TextEditingController _controller;
  String? _imageAssetPath;
  String? _objFilePath;
  late UnityWidgetController _unityWidgetController;

  final List<String> _imageAssets = [
    'assets:/images/sample_image1.png',
    'assets/images/sample_image2.png',
    'assets/images/sample_image3.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadNotes(); // Φόρτωσε τις σημειώσεις όταν ανοίγει η σελίδα
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Αποθήκευση σημειώσεων και επιλεγμένων εικόνων/3D μοντέλων
  void _saveNotes(String notes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('course_notes_${widget.courseTitle}', notes);
    if (_imageAssetPath != null) {
      await prefs.setString(
          'course_image_${widget.courseTitle}', _imageAssetPath!);
    }
    if (_objFilePath != null) {
      await prefs.setString('course_3d_${widget.courseTitle}', _objFilePath!);
    }
  }

  // Φόρτωση αποθηκευμένων δεδομένων
  void _loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedNotes = prefs.getString('course_notes_${widget.courseTitle}');
    String? savedImage = prefs.getString('course_image_${widget.courseTitle}');
    String? savedObjFilePath =
        prefs.getString('course_3d_${widget.courseTitle}');
    setState(() {
      _controller.text = savedNotes ??
          ''; // Αν δεν υπάρχει αποθηκευμένο κείμενο, άφησέ το κενό
      _imageAssetPath = savedImage;
      _objFilePath = savedObjFilePath;
    });
  }

  // Επιλογή εικόνας από τα assets
  void _pickImageFromAssets(String imagePath) {
    setState(() {
      _imageAssetPath = imagePath;
    });
    _saveNotes(
        _controller.text); // Αποθήκευση σημειώσεων μετά την επιλογή εικόνας
  }

  // Εμφάνιση διαλόγου για την επιλογή εικόνας
  void _showImagePicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Επιλέξτε Εικόνα"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _imageAssets.map((imagePath) {
                return GestureDetector(
                  onTap: () {
                    _pickImageFromAssets(imagePath);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      imagePath,
                      width: 100,
                      height: 100,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  // Επιλογή 3D μοντέλου (παράδειγμα)
  Future<void> _pick3DModel() async {
    setState(() {
      _objFilePath = "assets/models/sample.obj"; // Προσαρμόστε το ανάλογα
    });
    _saveNotes(
        _controller.text); // Αποθήκευση σημειώσεων μετά την επιλογή 3D μοντέλου
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
        backgroundColor: Colors.deepPurple[800],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField για σημειώσεις
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _controller,
                  maxLines:
                      null, // Επιτρέπει στο TextField να μεγαλώνει με το περιεχόμενο
                  decoration: const InputDecoration(
                    hintText: "Γράψε τις σημειώσεις σου εδώ...",
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 18),
                  onChanged: (text) {
                    _saveNotes(
                        text); // Αποθηκεύει το κείμενο κάθε φορά που αλλάζει
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Εμφάνιση επιλεγμένης εικόνας (αν υπάρχει)
              if (_imageAssetPath != null)
                Image.asset(
                  _imageAssetPath!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 20),
              // Κουμπί για προσθήκη εικόνας από τα assets
              ElevatedButton(
                onPressed: _showImagePicker,
                child: const Text("Προσθήκη εικόνας"),
              ),
              const SizedBox(height: 20),
              // Εμφάνιση 3D μοντέλου μέσω Unity (παράδειγμα)
              _objFilePath != null
                  ? SizedBox(
                      height: 300,
                      child: UnityWidget(
                        onUnityCreated: (controller) {
                          _unityWidgetController = controller;
                          _unityWidgetController.postMessage(
                            'Cube',
                            'SetModel',
                            _objFilePath!,
                          );
                        },
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _pick3DModel,
                      child: const Text("Προσθήκη 3D μοντέλου"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
