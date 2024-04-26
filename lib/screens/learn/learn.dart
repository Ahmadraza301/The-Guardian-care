import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  // ignore: unused_field
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<String> categories;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('videos').get();
    Set<String> categorySet = Set();
    querySnapshot.docs.forEach((doc) {
      final category = doc['category'] as String?;
      if (category != null) {
        categorySet.add(category);
      }
    });
    setState(() {
      categories = categorySet.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory ?? 'Video List'),
      ),
      body: selectedCategory != null
          ? VideoList(category: selectedCategory!)
          : CategoryList(categories: categories, onSelectCategory: selectCategory),
    );
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }
}

class CategoryList extends StatelessWidget {
  final List<String> categories;
  final Function(String) onSelectCategory;

  const CategoryList({super.key,
    required this.categories,
    required this.onSelectCategory,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category),
          onTap: () => onSelectCategory(category),
        );
      },
    );
  }
}

class VideoList extends StatelessWidget {
  final String category;

  const VideoList({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('videos')
          .where('category', isEqualTo: category)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        List<QueryDocumentSnapshot> videos = snapshot.data!.docs;
        return ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            var video = videos[index].data() as Map<String, dynamic>;
            return VideoListItem(
              videoTitle: video['title'] ?? 'Untitled',
              videoUrl: video['videoUrl'] as String? ?? '',
            );
          },
        );
      },
    );
  }
}

class VideoListItem extends StatelessWidget {
  final String videoTitle;
  final String videoUrl;

  const VideoListItem({super.key, required this.videoTitle, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(videoTitle),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(videoUrl: videoUrl),
          ),
        );
      },
    );
  }
}

class VideoPlayerPage extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerPage({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Video Player'),
        ),
        body: const Center(
          child: Text('Invalid YouTube URL'),
        ),
      );
    }

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          progressColors: const ProgressBarColors(
            playedColor: Colors.blue,
            handleColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
