import 'package:flutter/material.dart';

class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title,
    required this.isDone,
  });
}

class TodoHomePage extends StatefulWidget{
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _todos.add(Todo(title: _controller.text, isDone: false));
      });
    }
  }

  void _toggleTodoStatus(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TodoInputField(
            controller: _controller,
            onAdd: _addTodo,
          ),
          Expanded(
            child: TodoList(
              todos: _todos,
              onToggle: _toggleTodoStatus,
              onDelete: _removeTodo,
            ),
          )
        ],
      ),
    );
  }
}

class TodoInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const TodoInputField ({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Tambahkan tugas...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(onPressed: onAdd, child: const Text("Tambah"))
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(int) onToggle;
  final Function(int) onDelete;

  const TodoList({
    super.key,
    required this.todos,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(child: Text("Belum ada tugas"));
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoItem(
          todo: todos[index],
          onToggle: () => onToggle(index),
          onDelete: () => onDelete(index),
        );
      }
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override 
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone, 
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none
          ),
        ),
        trailing: IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: Colors.red,)),
      ),
    );
  }
}

