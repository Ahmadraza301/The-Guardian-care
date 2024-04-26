import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guardiancare/screens/account/account.dart';
import 'package:guardiancare/screens/emergency/emergency_contact_page.dart';
import 'package:guardiancare/screens/learn/learn.dart';
import 'package:guardiancare/screens/quizpage/quiz_page.dart';
import 'package:guardiancare/screens/search/search_page.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> videoData = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    fetchVideoTitles();
  }

  Future<void> fetchVideoTitles() async {
    final videoUrls = [
      'https://www.youtube.com/watch?v=d5dCN66PokQ',
      'https://www.youtube.com/watch?v=_MXD-eL4z_M',
      'https://www.youtube.com/watch?v=sehKCzxIblQ',
      'https://www.youtube.com/watch?v=qRLqkqWBJPE',
      'https://www.youtube.com/watch?v=3SzazN2OrsQ',
    ];

    for (final videoUrl in videoUrls) {
      final response = await http.get(Uri.parse(videoUrl));
      if (response.statusCode == 200) {
        final thumbnailUrl = await _getThumbnailUrl(videoUrl);
        videoData.add({
          'url': videoUrl,
          'thumbnailUrl': thumbnailUrl,
        });
      } else {
        print('Failed to fetch video thumbnail for $videoUrl');
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 2,
                  aspectRatio: 16 / 9, // Adjust aspect ratio for full width image
                  viewportFraction: 1, // Full width image
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  scrollDirection: Axis.horizontal,
                ),
                items: videoData.isEmpty
                    ? _buildShimmerItems()
                    : videoData.map((video) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebViewPage(url: video['url']),
                            ),
                          );
                        },
                        child: AspectRatio(
                          aspectRatio: 16 / 9, // Aspect ratio for image
                          child: Image.network(
                            video['thumbnailUrl'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                elevation: 8,
                color: Colors.blue[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircularButton(Icons.quiz, 'Quiz', context),
                          _buildCircularButton(Icons.search, 'Search', context),
                          _buildCircularButton(
                              Icons.person, 'Profile', context),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircularButton(
                              Icons.favorite, 'Favorites', context),
                          _buildCircularButton(
                              Icons.emergency, 'Emergency', context),
                          _buildCircularButton(
                              Icons.video_library, 'Learn', context),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton(
      IconData iconData, String label, BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            if (label == 'Quiz') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuizPage()),
              );
            } else if (label == 'Emergency') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmergencyContactPage(),
                ),
              );
            } else if (label == 'Search') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            } else if (label == 'Profile') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Account(user: _user),
                ),
              );
            } else if (label == 'Learn') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VideoPage(),
                ),
              );
            } else {
              // Handle other button presses
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.cyan,
            backgroundColor: Colors.green,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          child: Icon(iconData, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(label),
      ],
    );
  }

  List<Widget> _buildShimmerItems() {
    return List.generate(5, (index) => _buildShimmerItem());
  }

  Widget _buildShimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.grey[300],
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Future<String> _getThumbnailUrl(String videoUrl) async {
    final videoId = _extractVideoId(videoUrl);
    return 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
  }

  String _extractVideoId(String url) {
    final regExp = RegExp(
        r"(?:https:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/|www\.youtube\.com\/\S*?[?&]v=)?([a-zA-Z0-9_-]{11})");
    final match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }
}

class WebViewPage extends StatelessWidget {
  final String url;
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YouTube Video')),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          // Handle page start event
        },
        onPageFinished: (String url) {
          // Handle page finish event
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onWebResourceError: (WebResourceError error) {
          // Handle web resource error
        },
        gestureNavigationEnabled: true, // Enable gesture navigation
        allowsInlineMediaPlayback: true, // Allow inline media playback
        debuggingEnabled: true, // Enable debugging
        userAgent: 'Custom User Agent', // Set custom user agent
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}
