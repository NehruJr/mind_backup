import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String title;
  final int icon;
  final String color;
  final String taskDate;
  final String priority;
  final List<dynamic>? todos;

  const TaskModel(
      {required this.title,
      required this.icon,
      required this.color,
      required this.taskDate,
      required this.priority,
      this.todos});

  TaskModel copyWith({
    String? title,
    int? icon,
    String? color,
    String? taskDate,
    String? priority,
    List<dynamic>? todos,
  }) =>
      TaskModel(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        todos: todos ?? this.todos,
        taskDate: taskDate ?? this.taskDate,
        priority: priority ?? this.priority,
      );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      title: json['title'],
      icon: json['icon'],
      color: json['color'],
      taskDate: json['taskDate'],
      priority: json['priority'],
      todos: json['todos']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'icon': icon,
        'color': color,
        'taskDate': taskDate,
        'priority': priority,
        'todos': todos,
      };

  @override
  List<Object?> get props => [title, icon, color, taskDate, priority];
}
