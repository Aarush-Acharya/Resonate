import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resonate/models/story.dart';
import 'package:resonate/views/screens/add_chapter_screen.dart';
import 'package:resonate/views/screens/chapter_play_screen.dart';
import 'package:resonate/views/screens/notifications_screen.dart';
import 'package:resonate/views/widgets/chapter_list_tile.dart';
import 'package:resonate/views/widgets/like_button.dart';

class StoryScreen extends StatelessWidget {
  final Story story;

  const StoryScreen({required this.story, super.key});

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to match the story's tint color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: story.tintColor.withOpacity(0.8),
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    story.tintColor.withOpacity(0.8),
                    story.tintColor.withOpacity(0.4),
                    story.tintColor.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Story Image
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, bottom: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  story.coverImageUrl,
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            LikeButton(
                              tintColor: story.tintColor,
                            )
                          ],
                        ),

                        const SizedBox(width: 16),
                        // Story Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Story Title
                              Text(
                                story.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 35,
                                      overflow: TextOverflow.ellipsis,
                                      fontStyle: FontStyle.normal,
                                      fontFamily: 'Inter',
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${story.likesCount} Likes',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Inter',
                                        ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Duration
                                  Text(
                                    '${story.totalMin} min',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Inter',
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              // Creator Info
                              Row(
                                children: [
                                  Text(
                                    'by',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Inter',
                                        ),
                                  ),
                                  const SizedBox(width: 15),
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundImage:
                                        NetworkImage(story.coverImageUrl),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    story.userIsCreator
                                        ? "You"
                                        : story.creatorName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontFamily: 'Inter',
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Created ${formatDateTime(story.creationDate)}',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontFamily: 'Inter',
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Chapters Section (Scrollable)
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // About Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'About',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Inter',
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          story.description,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                    fontFamily: 'Inter',
                                  ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Chapters Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Text(
                          'Chapters',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                fontStyle: FontStyle.normal,
                                fontFamily: 'Inter',
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: story.chapters.length,
                        itemBuilder: (context, index) {
                          final chapter = story.chapters[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChapterPlayScreen(
                                    chapter: chapter,
                                  ),
                                ),
                              );
                            },
                            child: ChaperListTile(
                              chapter: chapter,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 50),

                      if (story.userIsCreator) ...[
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AddNewChapterScreen(
                                            storyName: story.title,
                                            storyId: story.storyId,
                                            currentChapters: story.chapters,
                                          )));
                            },
                            child: const Text('Add Chapter'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle delete story
                            },
                            child: const Text(
                              'Delete Story',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDate(DateTime date) {
  // Get the day, month, and year from the date
  int day = date.day;
  int month = date.month;
  int year = date.year;

  // Get the ordinal suffix (st, nd, rd, th)
  String getDayWithSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return '$day' 'th';
    }
    switch (day % 10) {
      case 1:
        return '$day' 'st';
      case 2:
        return '$day' 'nd';
      case 3:
        return '$day' 'rd';
      default:
        return '$day' 'th';
    }
  }

  // Convert month number to short month name
  List<String> monthNames = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String monthName = monthNames[month];

  // Construct the final formatted string
  return '${getDayWithSuffix(day)} $monthName $year';
}
