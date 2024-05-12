import 'package:flutter/material.dart';

class NewsArticle {
  final Text title;
  final Text description;
  final Uri link;

  NewsArticle({
    required this.title,
    required this.description,
    required this.link,
  });
}

// Data for the news page/home page.
final List<NewsArticle> latestNews = [
  NewsArticle(
    title: const Text(
      '2022 Indigenous Nationals',
    ),
    description: const Text(
      'Congratulations to the Macquarie students and staff who attended and competed in the 2022 Indigenous Nationals!',
    ),
    link:
        Uri.parse('https:/students.mq.edu.au/uni-life/whats-happening/news/2022-indigenous-nationals'),
  ),
  NewsArticle(
    title: const Text(
      'International Student Awards 2022',
    ),
    description: const Text(
      'Macquarie University is looking for nominations to showcase the excellence of our international student community.',
    ),
    link:
        Uri.parse('https://students.mq.edu.au/uni-life/whats-happening/news/international-student-awards-2022'),
  ),
  NewsArticle(
    title: const Text(
      'Gaining experience through virtual projects',
    ),
    description: const Text(
      'Find out how virtual programs provided by The Forage can help you learn more about potential career options.',
    ),
    link:
         Uri.parse('https://students.mq.edu.au/uni-life/whats-happening/news/gaining-experience-through-virtual-projects'),
  ),
  NewsArticle(
    title: const Text(
      'Benefits of joining a student group',
    ),
    description: const Text(
      'Hi everyone, my name’s Beckham and I\'m a 5th-year student studying a Bachelor of Commerce and Bachelor of Arts!',
    ),
    link:
         Uri.parse('https://students.mq.edu.au/uni-life/blog/student-life/clubs-societies-benefits'),
  ),
  NewsArticle(
    title: const Text(
      'Naidoc week',
    ),
    description: const Text(
      'On the occasion of NAIDOC Week join me in celebrating and recognising the history, culture and achievements of Aboriginal and Torres Strait Islander peoples under this year’s call to action ‘Get Up, Stand Up and Show Up’.',
    ),
    link:
         Uri.parse('https://students.mq.edu.au/uni-life/whats-happening/news/naidoc-week'),
  ),
  NewsArticle(
    title: const Text(
      'How I got my internship',
    ),
    description: const Text(
      'Hi, my name is Anushiya and I’m a Bachelor of Laws and Bachelor of Arts (Psychology) student. Last week I talked about the benefits of internships, but today I am giving you some tips on how I got my internship.',
    ),
    link:
         Uri.parse('https://students.mq.edu.au/uni-life/blog/internships/internship-tips'),
  ),
  NewsArticle(
    title: const Text(
      'Benefits of an internship',
    ),
    description: const Text(
      'Hi, my name is Anushiya and I’m a Bachelor of Laws and Bachelor of Arts (Psychology) student who has just finished an 8-week internship at Deloitte (and managed to score a return graduate job in 2023!).',
    ),
    link:
         Uri.parse('https://students.mq.edu.au/uni-life/blog/internships/internship-benefits'),
  ),
  NewsArticle(
    title: const Text(
      'Casual care service on campus',
    ),
    description: const Text(
      'Waratah Cottage offers services during school terms for children who only need care occasionally or for less than a full day.',
    ),
    link:
         Uri.parse('https://students.mq.edu.au/uni-life/whats-happening/news/casual-care'),
  ),
  NewsArticle(
    title: const Text(
      'Saving strategies',
    ),
    description: const Text(
      'Hi, my name’s Mahit and I’m a first-year Software Engineering student here at Macquarie.',
    ),
    link:
         Uri.parse('https://students.mq.edu.au/uni-life/blog/student-life/saving-strategies'),
  ),
];
