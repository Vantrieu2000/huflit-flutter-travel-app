import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'dart:convert';
import 'package:quiver/strings.dart';

List categories = [
  {"name": "Núi", "icon": Icons.terrain_rounded},
  {"name": "Bãi biển", "icon": Icons.beach_access_rounded},
  {"name": "Công viên", "icon": Icons.park_rounded},
  {"name": "Chùa", "icon": Icons.account_balance_rounded},
  {"name": "Thành phố", "icon": Icons.location_city_rounded},
  {"name": "Khác", "icon": Icons.widgets},
];

List exploreCategories = [
  {"name": "Quốc gia", "icon": Icons.terrain_rounded},
  {"name": "Bang", "icon": Icons.terrain_rounded},
  {"name": "Tỉnh biển", "icon": Icons.beach_access_rounded},
  {"name": "Địa điểm", "icon": Icons.park_rounded},
];

class Popular {
  final String id;
  final String name;
  final String image;

  const Popular({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Popular.fromJson(Map<String, dynamic> json) {
    return Popular(
      id: json['id'],
      name: json['name'],
      image: json['images'][0]['image'],
    );
  }
}

class Transportation {
  final String id;
  final String type;
  final String startFrom;
  final int subCharge;

  const Transportation({
    required this.id,
    required this.type,
    required this.startFrom,
    required this.subCharge,
  });

  factory Transportation.fromJson(Map<String, dynamic> json) {
    return Transportation(
      id: json['id'],
      type: json['type'],
      startFrom: json['startFrom'],
      subCharge: json['subCharge'],
    );
  }
}

class SubTour {
  final String id;
  final String checkIn;
  final String checkOut;
  final int slot;
  final List<Transportation> transportations;

  const SubTour({
    required this.id,
    required this.checkIn,
    required this.checkOut,
    required this.slot,
    required this.transportations,
  });

  factory SubTour.fromJson(Map<String, dynamic> json) {
    return SubTour(
        id: json['id'],
        checkIn: json['checkIn'],
        checkOut: json['checkOut'],
        slot: json['slot'],
        transportations: (json['transportations'] as List)
            .map((e) => Transportation.fromJson(e))
            .toList());
  }
}

class Tour {
  final String id;
  final String name;
  final String image;
  final String description;
  final String address;
  final String region;
  final int price;
  final int duration;
  final String schedule;
  final List<SubTour>? subTours;

  const Tour(
      {required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.address,
      required this.region,
      required this.schedule,
      required this.price,
      required this.duration,
      this.subTours});

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
        id: json['id'],
        name: json['name'],
        region: json['region'],
        address: json['address'],
        schedule: json['schedule'],
        price: json['price'],
        duration: json['duration'],
        description: json['description'],
        image: json['images'][0]['image']);
  }
  factory Tour.fromJsonWSubTour(Map<String, dynamic> json) {
    return Tour(
        id: json['id'],
        name: json['name'],
        region: json['region'],
        address: json['address'],
        schedule: json['schedule'],
        price: json['price'],
        duration: json['duration'],
        description: json['description'],
        image: json['images'][0]['image'],
        subTours: (json['subTours'] as List)
            .map((e) => SubTour.fromJson(e))
            .toList());
  }
}

Future<List<Popular>> fetchPopulars() async {
  var res = await http
      .get(Uri.parse('https://travelink-app.herokuapp.com/tour/statistic'));
  if (res.statusCode == 200) {
    var content = res.body;
    var arr = json.decode(content)['topTours'] as List;
    return arr.map((e) => Popular.fromJson(e)).toList();
  }
  return <Popular>[];
}

Future<List<Tour>> fetchTours() async {
  var res = await http
      .get(Uri.parse('https://travelink-app.herokuapp.com/tour?size=9999'));
  if (res.statusCode == 200) {
    var content = res.body;
    var arr = json.decode(content)['content'] as List;
    return arr.map((e) => Tour.fromJson(e)).toList();
  }
  return <Tour>[];
}

Future<Tour> fetchTourDetails(String id) async {
  var res = await http
      .get(Uri.parse('https://travelink-app.herokuapp.com/tour/${id}'));
  if (res.statusCode == 200) {
    var content = res.body;
    return Tour.fromJsonWSubTour(json.decode(content));
  }
  return null as Tour;
}

List populars = [
  {
    "image":
        "https://images.unsplash.com/photo-1606231140504-b6ec6cbbbf6b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Angkor",
    "location": "Siem Reap, Cambodia",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image": "https://data.whicdn.com/images/321215000/original.jpg",
    "name": "Fiji",
    "location": "Japan",
    "is_favorited": true,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1502783897899-5958a31ed82b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Paris",
    "location": "Paris, France",
    "is_favorited": true,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1628640816547-b7927d8638da?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Pyramid",
    "location": "Cairo, Egypt",
    "is_favorited": true,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1541429464955-87bd98d6d8f8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Bayon",
    "location": "Siem Reap, Cambodia",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1513326738677-b964603b136d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Moscow",
    "location": "Moscow, Russia",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1516496636080-14fb876e029d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Singapore",
    "location": "Singapore",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
];

List countries = [
  {
    "image":
        "https://images.unsplash.com/photo-1602642977157-b7c8b8003afd?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Cambodia",
    "location": "Cambodia",
    "is_favorited": true,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1526481280693-3bfa7568e0f3?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Japan",
    "location": "Japan",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1574227492706-f65b24c3688a?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Singapore",
    "location": "Singapore",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1565881606991-789a8dff9dbb?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "France",
    "location": "France",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1619870973878-e953baf30700?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Thailand",
    "location": "Thailand",
    "is_favorited": true,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1614555383820-941c466f1b52?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "China",
    "location": "China",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1553508978-314fe7d8cf77?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Italy",
    "location": "Italy",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1547448415-e9f5b28e570d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
    "name": "Russia",
    "location": "Russia",
    "is_favorited": false,
    "description":
        "Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document",
    "rate": 4,
    "id": "pro010",
  },
];
