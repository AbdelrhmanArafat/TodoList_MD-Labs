import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/controllers/todo_controller.dart';

void main() {
  late TodoController todoController;

  setUp(() {
    todoController = TodoController();
  });

  group('TodoController Tests', () async {
    test('should add a task to the list', () {
      expect(todoController.tasks.isEmpty, true);

      todoController.taskController.text = 'New Task';
      todoController.addTask();

      expect(todoController.tasks.length, 1);
      expect(todoController.tasks[0].title, 'New Task');
      expect(todoController.tasks[0].isCompleted, false);
    });

    test('should toggle task completion status', () {
      todoController.taskController.text = 'New Task';
      todoController.addTask();

      todoController.toggleTaskCompletion(0);

      expect(todoController.tasks[0].isCompleted, true);

      todoController.toggleTaskCompletion(0);

      expect(todoController.tasks[0].isCompleted, false);
    });

    test('should not add an empty task', () {
      todoController.taskController.text = '';

      todoController.addTask();

      expect(todoController.tasks.isEmpty, true);
    });
  });
}
