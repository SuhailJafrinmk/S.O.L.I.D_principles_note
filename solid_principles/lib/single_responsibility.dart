///////////////////////////////////////////////////////////////////////////////////////
/// Single Responsibility Principle (SRP)
/// The principle states that a class should have only one reason to change, meaning 
/// it should have only one responsibility. If a class takes on multiple responsibilities, 
/// it becomes harder to maintain and modify.

///////////////////////////////////////////////////////////////////////////////////////
/// Example violating the Single Responsibility Principle:
///
/// In this example, the `UserManager` class handles both the responsibility of user
/// management (saving and deleting users) and email notification (sending a welcome email).
/// This violates the SRP as it has more than one reason to change (user management 
/// logic and email logic).

class User {
  final String name;
  final String email;
  
  User({required this.name, required this.email});
}

class UserManagerWithoutSRP {
  /// This method handles both user management and email functionality.
  /// If either responsibility changes (database logic or email logic), this class must be modified.
  
  void saveUser(User user) {
    // Save user to the database
    print('User saved: ${user.name}');
  }

  void sendWelcomeMail(User user){
     // Send a welcome email (this should be in a different class)
    print('sending welcome email to ${user.email}');
  }

  void deleteUser(User user) {
    // Delete user from the database
    print('User deleted: ${user.name}');
  }
}

void main() {
  UserManagerWithoutSRP userManager = UserManagerWithoutSRP();
  User user = User(name: 'John Doe', email: 'john.doe@example.com');
  
  /// When we save a user, the same class is responsible for email sending, violating SRP.
  userManager.saveUser(user);
  userManager.deleteUser(user);
}

///////////////////////////////////////////////////////////////////////////////////////
/// Correct Implementation adhering to the Single Responsibility Principle (SRP):
///
/// Now, we follow the SRP by separating the concerns. 
/// The `UserDatabase` class is responsible for user management, while the `EmailService` 
/// class is responsible for handling emails. Each class has a single reason to change.

class User {
  final String name;
  final String email;
  
  User({required this.name, required this.email});
}

/// This class handles the logic related to user management (saving and deleting users),
/// adhering to SRP by focusing on just one responsibility.
class UserDatabase {
  void saveUser(User user) {
    // Save user to the database
    print('User saved to database: ${user.name}');
  }

  void deleteUser(User user) {
    // Delete user from the database
    print('User deleted from database: ${user.name}');
  }
}

/// This class handles the logic related to sending emails to users,
/// adhering to SRP by having only the responsibility of sending emails.
class EmailService {
  void sendWelcomeMail(User user) {
    // Send a welcome mail to the user
    print('Welcome email sent to: ${user.email}');
  }
}

void main() {
  User user = User(name: 'John Doe', email: 'john.doe@example.com');
  
  UserDatabase userDatabase = UserDatabase();
  EmailService emailService = EmailService();
  
  /// The user management and email logic are now separated into different classes.
  userDatabase.saveUser(user);
  emailService.sendWelcomeMail(user);
  userDatabase.deleteUser(user);
}
