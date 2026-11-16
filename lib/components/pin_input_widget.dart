import 'package:flutter/material.dart';

/// PIN-код компонент с 4 окошками и подтверждением
class PINInputWidget extends StatefulWidget {
  final Function(String) onComplete;
  final Function(String)? onChange;
  final bool isConfirmation;
  final String? title;

  const PINInputWidget({
    Key? key,
    required this.onComplete,
    this.onChange,
    this.isConfirmation = false,
    this.title,
  }) : super(key: key);

  @override
  State<PINInputWidget> createState() => _PINInputWidgetState();
}

class _PINInputWidgetState extends State<PINInputWidget> {
  final List<String> _pinDigits = ['', '', '', ''];
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  bool _showError = false;
  String _errorMessage = '';

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleInput(int index, String value) {
    if (value.isEmpty) {
      setState(() {
        _pinDigits[index] = '';
      });
      return;
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return;
    }

    setState(() {
      _pinDigits[index] = value[0];
      _showError = false;
    });

    widget.onChange?.call(_pinDigits.join());

    if (index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else {
      // Все 4 цифры введены
      FocusScope.of(context).unfocus();
      widget.onComplete(_pinDigits.join());
    }
  }

  void _handleBackspace(int index) {
    if (_pinDigits[index].isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void showError(String message) {
    setState(() {
      _showError = true;
      _errorMessage = message;
      // Очищаем PIN при ошибке
      for (int i = 0; i < _pinDigits.length; i++) {
        _pinDigits[i] = '';
      }
      _focusNodes[0].requestFocus();
    });

    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showError = false;
        });
      }
    });
  }

  void clear() {
    setState(() {
      for (int i = 0; i < _pinDigits.length; i++) {
        _pinDigits[i] = '';
      }
      _showError = false;
    });
    _focusNodes[0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
        ],
        // PIN окошки
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: 60,
                height: 60,
                child: TextField(
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  obscureText: true,
                  obscuringCharacter: '●',
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _showError ? Colors.red : Colors.grey,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: _showError ? Colors.red : Colors.blue,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  style: Theme.of(context).textTheme.headlineMedium,
                  onChanged: (value) => _handleInput(index, value),
                  onRawKeyEvent: (event) {
                    if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
                      _handleBackspace(index);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 24),
        // Сообщение об ошибке
        if (_showError)
          Text(
            _errorMessage,
            style: TextStyle(color: Colors.red, fontSize: 14),
          ),
        // Подсказка для подтверждения
        if (widget.isConfirmation)
          Text(
            'Подтвердите ПИН-код',
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}

/// Экран входа с ПИН-кодом
class PINLoginScreen extends StatefulWidget {
  final Function(String) onLogin;

  const PINLoginScreen({
    Key? key,
    required this.onLogin,
  }) : super(key: key);

  @override
  State<PINLoginScreen> createState() => _PINLoginScreenState();
}

class _PINLoginScreenState extends State<PINLoginScreen> {
  final GlobalKey<_PINInputWidgetState> _pinKey =
      GlobalKey<_PINInputWidgetState>();
  int _failedAttempts = 0;
  static const int _maxAttempts = 3;
  bool _isLocked = false;

  void _handlePINComplete(String pin) {
    // Здесь будет проверка PIN
    // Пока просто логируем
    print('PIN введён: $pin');

    // Проверка в реальном приложении:
    // - Сравнить с сохранённым PIN
    // - Если неправильно - показать ошибку и увеличить счётчик
    // - После 3 ошибок - заблокировать на время

    if (_failedAttempts >= _maxAttempts) {
      setState(() {
        _isLocked = true;
      });
      _pinKey.currentState?.showError('Заблокировано. Попробуйте позже');
      return;
    }

    // Временная логика - любой 4-значный PIN принимаем
    if (pin.length == 4) {
      widget.onLogin(pin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WorkDesk')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: PINInputWidget(
            key: _pinKey,
            title: 'Введите ПИН-код',
            onComplete: _isLocked ? (_) {} : _handlePINComplete,
          ),
        ),
      ),
    );
  }
}

/// Экран установки ПИН-кода (первый раз)
class PINSetupScreen extends StatefulWidget {
  final Function(String) onSetup;

  const PINSetupScreen({
    Key? key,
    required this.onSetup,
  }) : super(key: key);

  @override
  State<PINSetupScreen> createState() => _PINSetupScreenState();
}

class _PINSetupScreenState extends State<PINSetupScreen> {
  final GlobalKey<_PINInputWidgetState> _firstPinKey =
      GlobalKey<_PINInputWidgetState>();
  final GlobalKey<_PINInputWidgetState> _confirmPinKey =
      GlobalKey<_PINInputWidgetState>();

  String? _firstPin;
  bool _showConfirmation = false;

  void _handleFirstPin(String pin) {
    setState(() {
      _firstPin = pin;
      _showConfirmation = true;
    });
  }

  void _handleConfirmPin(String pin) {
    if (pin == _firstPin) {
      // PIN-ы совпадают
      widget.onSetup(pin);
    } else {
      // PIN-ы не совпадают
      _confirmPinKey.currentState?.showError('ПИН-ы не совпадают');
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _showConfirmation = false;
            _firstPin = null;
            _firstPinKey.currentState?.clear();
            _confirmPinKey.currentState?.clear();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Установить ПИН-код')),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: _showConfirmation
              ? PINInputWidget(
                  key: _confirmPinKey,
                  title: 'Подтвердите ПИН-код',
                  isConfirmation: true,
                  onComplete: _handleConfirmPin,
                )
              : PINInputWidget(
                  key: _firstPinKey,
                  title: 'Создайте ПИН-код',
                  onComplete: _handleFirstPin,
                ),
        ),
      ),
    );
  }
}
