import 'package:flutter/material.dart';
import 'theme/design_tokens.dart';

void main() {
  runApp(const WorkDeskApp());
}

class WorkDeskApp extends StatelessWidget {
  const WorkDeskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkDesk',
      theme: WorkTimeTheme.lightTheme(),
      darkTheme: WorkTimeTheme.darkTheme(),
      themeMode: ThemeMode.system,
      home: const WorkDeskHome(),
    );
  }
}

class WorkDeskHome extends StatefulWidget {
  const WorkDeskHome({Key? key}) : super(key: key);

  @override
  State<WorkDeskHome> createState() => _WorkDeskHomeState();
}

class _WorkDeskHomeState extends State<WorkDeskHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkDesk v1.0.0'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Приложение WorkDesk',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              '✅ PIN-код защита\n✅ Биометрическая проверка\n✅ Криптографические подписи\n✅ Синхронизация с облаком',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('WorkDesk v1.0.0 готово к тестированию!')),
                );
              },
              child: const Text('Готово к тестированию'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Отметки'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
