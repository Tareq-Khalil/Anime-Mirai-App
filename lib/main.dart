import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime App'),
        leading: Icon(Icons.arrow_back),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(
                  'Youkosu, Watashi no Soul Society',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                    'Description: Welcome, my friend otaku. This is my anime app which I have not finished yet. Please sign in to make a future account.'),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: FadeInImage.assetNetwork(
              placeholder: '',
              image:
                  'https://th.bing.com/th/id/OIP.S4LK_wBSr__FHA4zw9bUrgHaHa?w=1080&h=1080&rs=1&pid=ImgDetMain',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Sign In'),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  SignInScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          );
        },
      ),
    );
  }
}





class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
   
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  void _signIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AnimeSelectionScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://th.bing.com/th/id/OIP.Xk1-9916hCbfexX8oqmKSQHaEK?w=293&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: _validateUsername,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                    validator: _validatePassword,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _signIn(context),
                    child: Text('Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Anime'),
      ),
      body: ListView(
        children: [
          _buildAnimeButton(context, 'Kimetsu no Yaiba', 'https://th.bing.com/th/id/OIP.XD87LNTWo4zSMow_zhU-IQHaFL?w=261&h=183&c=7&r=0&o=5&dpr=1.5&pid=1.7'),
          _buildAnimeButton(context, 'Classroom of the Elite', 'https://th.bing.com/th/id/OIP.DWoyztbvmCrfjK82xwHjwgHaLp?pid=ImgDet&w=178&h=279&c=7&dpr=1.5'),
          _buildAnimeButton(context, 'Rokka no Yuusha', 'https://th.bing.com/th/id/OIP.Qt98Ooqgqmj-lUb7P2aVxAHaFj?pid=ImgDet&w=178&h=133&c=7&dpr=1.5'),
          _buildAnimeButton(context, 'I\'m Standing on a Million Lives', 'https://th.bing.com/th/id/OIP.knGOdHshMRbJAW51ORER_QAAAA?pid=ImgDet&w=178&h=247&c=7&dpr=1.5'),
          _buildAnimeButton(context, 'Tsukimichi Moonlit Fantasy', 'https://th.bing.com/th/id/OIP.B-NeWNvVXI0TCDTqkKvZlQHaKX?pid=ImgDet&w=178&h=249&c=7&dpr=1.5'),
          _buildAnimeButton(context, 'Kaguya-sama: Love Is War', 'https://th.bing.com/th/id/OIP.7C5NtQ-s5zDY11dkOXfBzgHaKb?pid=ImgDet&w=178&h=250&c=7&dpr=1.5'),
          _buildAnimeButton(context, 'Chunibyou demo Koi ga Shitai', 'https://th.bing.com/th/id/OIP.y9A9JYkv-rdjRRVeCjqhWgHaKW?pid=ImgDet&w=178&h=249&c=7&dpr=1.5'),
          _buildAnimeButton(context, 'Tate no Yuusha no Nariagari', 'https://th.bing.com/th/id/OIP.4d5L9gK9H1oh7py3PlIP2wHaKe?pid=ImgDet&w=178&h=251&c=7&dpr=1.5'),
          _buildAnimeButton(context, 'No Game No Life', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHe1vBW8DWoPNAocTRHcy8XUrdcdg4sITvIJjPyRrNX0tGNUkP-pwO4FtzWxip6qVTUE4&usqp=CAU'),
          _buildAnimeButton(context, 'Mairimashita! Iruma-kun', 'https://th.bing.com/th/id/OIP.fxKp3BNUp9GryVV9ydBDXgAAAA?pid=ImgDet&w=178&h=251&c=7&dpr=1.5'),
        ],
      ),
    );
  }

  Widget _buildAnimeButton(BuildContext context, String title, String imageUrl) {
    return ListTile(
      leading: Image.network(imageUrl, width: 50, height: 50),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimeDetailScreen(animeTitle: title, animeImageUrl: imageUrl),
          ),
        );
      },
    );
  }
}

class AnimeDetailScreen extends StatelessWidget {
  final String animeTitle;
  final String animeImageUrl;

  AnimeDetailScreen({required this.animeTitle, required this.animeImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animeTitle),
      ),
      body: Column(
        children: [
          Image.network(animeImageUrl),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Characters'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterSelectionScreen(animeTitle: animeTitle),
                      ),
                    );
                  },
                ),
                // Add more anime details here
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterSelectionScreen extends StatelessWidget {
  final String animeTitle;

  CharacterSelectionScreen({required this.animeTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$animeTitle Characters'),
      ),
      body: ListView(
        children: _getCharacterList(context),
      ),
    );
  }

  List<Widget> _getCharacterList(BuildContext context) {
    final characterList = {
      'Kimetsu no Yaiba': [
        {
          'name': 'Tanjiro Kamado',
          'description': 'Tanjiro Kamado is the main protagonist of the series. He is a kind-hearted and determined young boy who becomes a demon slayer to avenge his family and find a cure for his sister Nezuko.',
          'age' : '13 (Chapter 1)',
          'height': '165 cm',
          'weight': '61 kg',
          'birthday': 'July 14',
          'occupation': 'Demon Slayer',
          'hairColor': 'Black to Red',
          'eyeColor': 'Dark Red',
        },
        {
          'name': 'Nezuko Kamado',
          'description': 'Nezuko Kamado is Tanjiro’s younger sister who was transformed into a demon. Despite being a demon, she retains her human emotions and fights to protect her brother and humanity.',
          'height': '153 cm',
          'weight': '45 kg',
          'birthday': 'December 28',
          'occupation': 'Demon',
          'hairColor': 'Black',
          'eyeColor': 'Pink',
        },
      ],
      'Classroom of the Elite': [
        {
          'name': 'Kiyotaka Ayanokoji',
          'description': 'Kiyotaka Ayanokoji is a student of Class 1-D at Tokyo Metropolitan Advanced Nurturing High School. He is highly intelligent and skilled but prefers to stay in the background.',
          'height': '175 cm',
          'weight': '60 kg',
          'birthday': 'August 20',
          'occupation': 'Student',
          'hairColor': 'Black',
          'eyeColor': 'Dark Brown',
        },
        {
          'name': 'Suzune Horikita',
          'description': 'Suzune Horikita is a member of Class 1-D and has a strong desire to improve her academic standing. She is intelligent but often struggles with social interactions.',
          'height': '165 cm',
          'weight': '50 kg',
          'birthday': 'July 23',
          'occupation': 'Student',
          'hairColor': 'Black',
          'eyeColor': 'Black',
        },
      ],
      'Rokka no Yuusha': [
        {
          'name': 'Adlet Mayer',
          'description': 'Adlet Mayer is the self-proclaimed strongest man in the world and one of the Six Braves. He is known for his confidence and combat skills.',
          'height': '180 cm',
          'weight': '75 kg',
          'birthday': 'May 3',
          'occupation': 'Brave',
          'hairColor': 'Black',
          'eyeColor': 'Dark Blue',
        },
        {
          'name': 'Nachetanya Vier',
          'description': 'Nachetanya Vier is one of the Six Braves and the princess of the Kynesol kingdom. She is skilled in magic and has a strong sense of justice.',
          'height': '162 cm',
          'weight': '48 kg',
          'birthday': 'November 10',
          'occupation': 'Princess, Brave',
          'hairColor': 'Light Blue',
          'eyeColor': 'Blue',
        },
      ],
      'I\'m Standing on a Million Lives': [
        {
          'name': 'Yotsuya Yuusuke',
          'description': 'Yotsuya Yuusuke is a high school student who gets transported to another world. He is known for his strategic thinking and survival skills.',
          'height': '170 cm',
          'weight': '62 kg',
          'birthday': 'March 25',
          'occupation': 'Adventurer',
          'hairColor': 'Black',
          'eyeColor': 'Dark Brown',
        },
        {
          'name': 'Iu Shindo',
          'description': 'Iu Shindo is a classmate of Yotsuya Yuusuke who gets transported to the same world. She is a skilled healer and has a calm personality.',
          'height': '158 cm',
          'weight': '50 kg',
          'birthday': 'December 1',
          'occupation': 'Healer',
          'hairColor': 'Brown',
          'eyeColor': 'Blue',
        },
      ],
      'Tsukimichi Moonlit Fantasy': [
        {
          'name': 'Mochizuki Makoto',
          'description': 'Mochizuki Makoto is the protagonist of the series who gets transported to a fantasy world. He is a powerful warrior with exceptional skills.',
          'height': '177 cm',
          'weight': '70 kg',
          'birthday': 'July 1',
          'occupation': 'Adventurer',
          'hairColor': 'Black',
          'eyeColor': 'Gray',
        },
        {
          'name': 'Tomoe',
          'description': 'Tomoe is a high-ranking Onmyouji who serves as Makoto’s guardian. She is known for her loyalty and powerful magic.',
          'height': '160 cm',
          'weight': '45 kg',
          'birthday': 'August 12',
          'occupation': 'Guardian',
          'hairColor': 'White',
          'eyeColor': 'Red',
        },
      ],
      'Kaguya-sama: Love Is War': [
        {
          'name': 'Kaguya Shinomiya',
          'description': 'Kaguya Shinomiya is a student council vice-president who is known for her beauty and intelligence. She engages in a battle of wits with Miyuki Shirogane.',
          'height': '157 cm',
          'weight': '45 kg',
          'birthday': 'February 21',
          'occupation': 'Student Council Vice-President',
          'hairColor': 'Black',
          'eyeColor': 'Dark Blue',
        },
        {
          'name': 'Miyuki Shirogane',
          'description': 'Miyuki Shirogane is the student council president who excels academically and in sports. He is the main rival of Kaguya Shinomiya.',
          'height': '175 cm',
          'weight': '60 kg',
          'birthday': 'November 3',
          'occupation': 'Student Council President',
          'hairColor': 'White',
          'eyeColor': 'Blue',
        },
      ],
      'Chunibyou demo Koi ga Shitai': [
        {
          'name': 'Yuta Togashi',
          'description': 'Yuta Togashi is a high school student who suffers from "chunibyo" syndrome. He is trying to leave behind his delusions of being a dark sorcerer.',
          'height': '172 cm',
          'weight': '63 kg',
          'birthday': 'February 29',
          'occupation': 'Student',
          'hairColor': 'Black',
          'eyeColor': 'Brown',
        },
        {
          'name': 'Rikka Takanashi',
          'description': 'Rikka Takanashi is a girl with chunibyo syndrome who believes she has magical powers. She is enthusiastic and energetic.',
          'height': '160 cm',
          'weight': '50 kg',
          'birthday': 'November 3',
          'occupation': 'Student',
          'hairColor': 'Black',
          'eyeColor': 'Purple',
        },
      ],
      'Tate no Yuusha no Nariagari': [
        {
          'name': 'Naofumi Iwatani',
          'description': 'Naofumi Iwatani is the protagonist of the series who is summoned to another world as the Shield Hero. He is initially ostracized but grows stronger through adversity.',
          'height': '180 cm',
          'weight': '80 kg',
          'birthday': 'June 21',
          'occupation': 'Shield Hero',
          'hairColor': 'Black',
          'eyeColor': 'Green',
        },
        {
          'name': 'Raphtalia',
          'description': 'Raphtalia is a demi-human and Naofumi’s companion. She starts as a slave but grows to become a loyal and strong ally.',
          'height': '150 cm',
          'weight': '45 kg',
          'birthday': 'July 15',
          'occupation': 'Adventurer',
          'hairColor': 'Brown',
          'eyeColor': 'Blue',
        },
      ],
      'No Game No Life': [
        {
          'name': 'Sora',
          'description': 'Sora is one of the protagonists of the series who, along with his sister Shiro, is transported to a world where all conflicts are resolved through games.',
          'height': '165 cm',
          'weight': '60 kg',
          'birthday': 'January 1',
          'occupation': 'Gamer',
          'hairColor': 'Black',
          'eyeColor': 'Red',
        },
        {
          'name': 'Shiro',
          'description': 'Shiro is Sora’s younger sister and a gaming prodigy. She is extremely intelligent and plays games with an almost supernatural skill.',
          'height': '150 cm',
          'weight': '40 kg',
          'birthday': 'April 17',
          'occupation': 'Gamer',
          'hairColor': 'White',
          'eyeColor': 'Blue',
        },
      ],
      'Mairimashita! Iruma-kun': [
        {
          'name': 'Iruma Suzuki',
          'description': 'Iruma Suzuki is a human who is taken to the demon world and ends up attending a demon school. Despite being human, he becomes popular and succeeds in the demon world.',
          'height': '165 cm',
          'weight': '55 kg',
          'birthday': 'March 5',
          'occupation': 'Student',
          'hairColor': 'Black',
          'eyeColor': 'Green',
        },
        {
          'name': 'Alice Asmodeus',
          'description': 'Alice Asmodeus is a demon prince and one of Iruma’s classmates. He is proud and has a strong sense of honor.',
          'height': '170 cm',
          'weight': '65 kg',
          'birthday': 'October 10',
          'occupation': 'Student',
          'hairColor': 'Red',
          'eyeColor': 'Gold',
        },
      ],
    };

    return characterList[animeTitle]?.map((character) {
      return ListTile(
        title: Text(character['name'] as String),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetailScreen(
                name: character['name'] as String,
                description: character['description'] as String,
                height: character['height'] as String,
                weight: character['weight'] as String,
                birthday: character['birthday'] as String,
                occupation: character['occupation'] as String,
                hairColor: character['hairColor'] as String,
                eyeColor: character['eyeColor'] as String,
              ),
            ),
          );
        },
      );
    }).toList() ?? [];
  }
}

class CharacterDetailScreen extends StatelessWidget {
  final String name;
  final String description;
  final String height;
  final String weight;
  final String birthday;
  final String occupation;
  final String hairColor;
  final String eyeColor;

  CharacterDetailScreen({
    required this.name,
    required this.description,
    required this.height,
    required this.weight,
    required this.birthday,
    required this.occupation,
    required this.hairColor,
    required this.eyeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            DataTable(
              columns: const [
                DataColumn(label: Text('Attribute')),
                DataColumn(label: Text('Details')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Height')),
                  DataCell(Text(height)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Weight')),
                  DataCell(Text(weight)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Birthday')),
                  DataCell(Text(birthday)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Occupation')),
                  DataCell(Text(occupation)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Hair Color')),
                  DataCell(Text(hairColor)),
                ]),
                DataRow(cells: [
                  DataCell(Text('Eye Color')),
                  DataCell(Text(eyeColor)),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
