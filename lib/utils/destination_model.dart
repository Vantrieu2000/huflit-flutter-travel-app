import 'package:travelink_app/utils/activity_model.dart';

class Destination {
  String imageUrl;
  String city;
  String country;
  String description;
  List<Activity> activities;

  Destination({
    required this.imageUrl,
    required this.city,
    required this.country,
    required this.description,
    required this.activities,
  });
}

List<Activity> activities = [
  Activity(
    imageUrl: 'assets/images/stmarksbasilica.jpg',
    name: 'St. Mark\'s Basilica',
    type: 'Sightseeing Tour',
    startTimes: ['9:00 am', '11:00 am'],
    rating: 5,
    price: 30,
  ),
  Activity(
    imageUrl: 'assets/images/gondola.jpg',
    name: 'Walking Tour and Gonadola Ride',
    type: 'Sightseeing Tour',
    startTimes: ['11:00 pm', '1:00 pm'],
    rating: 4,
    price: 210,
  ),
  Activity(
    imageUrl: 'assets/images/murano.jpg',
    name: 'Murano and Burano Tour',
    type: 'Sightseeing Tour',
    startTimes: ['12:30 pm', '2:00 pm'],
    rating: 3,
    price: 125,
  ),
];

List<Destination> destinations = [
  Destination(
    imageUrl:
        "https://images.unsplash.com/photo-1606231140504-b6ec6cbbbf6b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    city: 'Angkor',
    country: 'Cambodia',
    description: 'Visit Angkor for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl: 'https://data.whicdn.com/images/321215000/original.jpg',
    city: 'Fiji',
    country: 'Japan',
    description: 'Visit Fiji for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl:
        "https://images.unsplash.com/photo-1502783897899-5958a31ed82b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    city: 'Paris',
    country: 'France',
    description: 'Visit New Paris for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl:
        "https://images.unsplash.com/photo-1628640816547-b7927d8638da?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    city: 'Cairo',
    country: 'Egypt',
    description: 'Visit Sao Cairo for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl:
        "https://images.unsplash.com/photo-1541429464955-87bd98d6d8f8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    city: 'Bayon',
    country: 'Cambodia',
    description: 'Visit Bayon for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl:
        "https://images.unsplash.com/photo-1513326738677-b964603b136d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    city: 'Moscow',
    country: 'Russia',
    description: 'Visit Moscow for an amazing and unforgettable adventure.',
    activities: activities,
  ),
  Destination(
    imageUrl:
        "https://images.unsplash.com/photo-1516496636080-14fb876e029d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    city: 'Singapore',
    country: 'Singapore',
    description: 'Visit Singapore for an amazing and unforgettable adventure.',
    activities: activities,
  ),
];
