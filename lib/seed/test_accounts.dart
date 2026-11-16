class TestAccount {
  final String id;
  final String email;
  final String password;
  final String role;
  final String name;
  final String department;
  final bool isActive;
  final Map<String, bool> permissions;

  TestAccount({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.name,
    required this.department,
    required this.isActive,
    required this.permissions,
  });
}

class TestAccounts {
  static const String TEST_PASSWORD = 'TestPass2024!';

  static final TestAccount ADMIN = TestAccount(
    id: 'admin_001',
    email: 'admin@workdesk.test',
    password: TEST_PASSWORD,
    role: 'Admin',
    name: 'Администратор',
    department: 'IT',
    isActive: true,
    permissions: {
      'view_all_users': true,
      'manage_users': true,
      'manage_roles': true,
      'view_reports': true,
      'export_data': true,
    },
  );

  static final TestAccount MANAGER = TestAccount(
    id: 'manager_001',
    email: 'manager@workdesk.test',
    password: TEST_PASSWORD,
    role: 'Manager',
    name: 'Менеджер',
    department: 'Sales',
    isActive: true,
    permissions: {
      'view_team': true,
      'approve_timecards': true,
      'view_reports': true,
    },
  );

  static final TestAccount EMPLOYEE = TestAccount(
    id: 'employee_001',
    email: 'employee@workdesk.test',
    password: TEST_PASSWORD,
    role: 'Employee',
    name: 'Сотрудник',
    department: 'Engineering',
    isActive: true,
    permissions: {
      'submit_timecards': true,
      'view_own_reports': true,
    },
  );

  static List<TestAccount> getAll() {
    return [ADMIN, MANAGER, EMPLOYEE];
  }

  static TestAccount? getByEmail(String email) {
    try {
      return getAll().firstWhere((account) => account.email == email);
    } catch (e) {
      return null;
    }
  }

  static List<TestAccount> getByRole(String role) {
    return getAll().where((account) => account.role == role).toList();
  }

  static List<TestAccount> getActive() {
    return getAll().where((account) => account.isActive).toList();
  }
}
