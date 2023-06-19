// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String id;
  Color? color;
  final String title;
  final String description;
  final String regDate;
  bool? isDone;
  bool? isDeleted;
  bool? isFavorite;
  Task({
    required this.id,
    required this.title,
    this.color,
    required this.description,
    required this.regDate,
    this.isDone,
    this.isDeleted,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDeleted = isDeleted ?? false;
    isFavorite = isFavorite ?? false;
  }

  Task copyWith({
    String? id,
    String? title,
    Color? color,
    String? description,
    String? regDate,
    bool? isDone,
    bool? isDeleted,
    bool? isFavorite,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      description: title ?? this.description,
      regDate: regDate ?? this.regDate,
      isDone: isDone ?? this.isDone,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'color': color?.value,
      'description': description,
      'regDate': regDate,
      'isDone': isDone,
      'isDeleted': isDeleted,
      'isFavorite': isFavorite,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      color: map['color'] != null ? Color(map['color']) : null,
      description: map['description'] ?? '',
      regDate: map['regDate'] ?? '',
      isDone: map['isDone'],
      isDeleted: map['isDeleted'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props =>
      [id, title, color, description, isFavorite, regDate, isDone, isDeleted];
}
