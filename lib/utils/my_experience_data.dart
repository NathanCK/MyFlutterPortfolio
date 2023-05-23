import 'package:flutter/material.dart';
import 'package:my_flutter_website/models/timeline_event_model.dart';

/// TODO: can store it on firestore or something like that.
final timelineEventModels = [
  TimelineEventModel(
    1,
    DateTime(2016, 9),
    DateTime(2019, 12),
    'BA in Computer Science',
    subtitle: 'University of Minnesota - Twin Cities',
    longDescription: '• Graduated with GPA 3.360.'
        '\n• Have taken fundamental courses, including Algorithms & Data Structures, and Program Design & Development.'
        '\n• Have taken advanced level courses, such as Operating Systems, and Computer Network.',
    timelineDotWidget: const Icon(
      Icons.book,
    ),
    icon: const Icon(Icons.ac_unit),
  ),
  TimelineEventModel(
    2,
    DateTime(2019, 10),
    DateTime(2020, 3),
    'Software Engineer Internship',
    subtitle: 'DeFiner Inc.',
    shortDescription: 'HTML, CSS, Javascript, and Angular',
    longDescription:
        '• Designed, implemented, and refined prototypes for a multitude of unique user interfaces, inspiring action around the results.'
        '\n• Used technology to solve straightforward user interface and UX problems, seeking input and guidance from team members.'
        '\n• Turned a defined software and UX design into code, and delivered it on schedule using languages, libraries, and rendering technologies (e.g. JavaScript, Node.js, Angular, HTML, CSS).',
    timelineDotWidget: const Icon(Icons.work),
  ),
  TimelineEventModel(
    3,
    DateTime(2020, 3),
    DateTime(2021, 1),
    'Software Developer',
    subtitle: 'Open Access Technology International, Inc.',
    shortDescription: 'C#, .NET Core 5, and Microsoft SQL Server',
    longDescription:
        '• Delivered new features and maintain the functionality of predictive modeling system for energy usage using C# and ASP.Net 5.'
        '\n• Implemented distributed in-memory caches to reduce the heavy reliability of SQL database in run-time using Apache Ignite.'
        '\n• Designed RESTful API to handle multiple requests simultaneously using MVC design pattern and Json.NET/System.Text.Json.'
        '\n• Wrote back-end unit tests and create a test program to ensure the functionality and correctness of the application using NUnit.'
        '\n• Used Microsoft SQL Server to consume data from and insert data rows into SQL database tables in the application.'
        '\n• Managed asynchronous work using TFS for version controlling.',
  ),
  TimelineEventModel(
    4,
    DateTime(2021, 7),
    DateTime(2021, 12),
    'Software Engineer',
    subtitle: 'Computer And Technologies Holdings Limited',
    shortDescription: 'Flutter, Dart',
    longDescription:
        '• Implemented new features and maintained the functionality of production level of iOS and Android point-of-sale(P.O.S) app and an inventory management app using Flutter, Dart, and BLoC design pattern.'
        '\n• Designed and delivered new features and maintain the back-end server to fulfill the need of the mobile P.O.S app using .Net framework.'
        '\n• Cooperated with engineers, support team and BA to complete Statement of Work and solve incidents from users using Waterfall methodology.'
        '\n• Designed unique user interfaces and created mock-up screens on Figma.'
        '\n• Integrated front-end and back-end elements using RESTful api.'
        '\n• Interacted with a third-party iOS app for payment purpose.',
  ),
  TimelineEventModel(
    5,
    DateTime(2022, 1),
    DateTime(2023, 1),
    'Mobile Development Engineer',
    subtitle: 'Signify',
    shortDescription: 'Flutter, Dart',
    longDescription:
        '• Revamped the original WiZ app that controls WiZ Connected smart devices using Flutter technology for cross-platform purpose.'
        '\n• Implemented new UI and features for over 10K+ users.'
        '\n• Used BLoC design pattern as the foundation of development process.'
        '\n• Wrote Flutter unit tests to ensure the functionality of the WiZ V2 app.'
        '\n• Experienced with RESTful API concepts and SQLite database.'
        '\n• Involved in an agile development environment with different teams for sprint planning, refinement, grooming, and daily stand-up meetings.',
  ),
];
