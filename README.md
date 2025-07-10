# Personal Money Manager

A comprehensive Flutter application for managing personal finances with income and expense tracking.

## Features

### 💰 Transaction Management
- **Add Transactions**: Easy-to-use form to add income and expense transactions
- **Transaction History**: View all transactions with detailed information
- **Newest First Sorting**: Transactions and analytics are always shown with the newest at the top
- **Delete Transactions**: Long press to delete unwanted transactions
- **Real-time Updates**: Live updates using Hive database

### 📊 Financial Overview
- **Balance Summary**: Real-time balance calculation
- **Income Tracking**: Total income with visual indicators
- **Expense Tracking**: Total expenses with visual indicators
- **Category-based Organization**: Transactions organized by categories

### 🏷️ Category Management
- **Pre-built Categories**: Default income and expense categories
- **Edit Categories**: Modify existing category names
- **Delete Categories**: Remove unwanted categories
- **Type-based Organization**: Separate income and expense categories

### 🎨 Modern UI/UX
- **Material Design 3**: Modern and intuitive interface
- **Responsive Design**: Works on all screen sizes
- **Color-coded Transactions**: Green for income, red for expenses
- **Smooth Animations**: Fluid transitions and interactions
- **Standard Font**: Uses the platform's default font for a native look and feel

## Technical Stack

- **Framework**: Flutter 3.8+
- **Database**: Hive (NoSQL local database)
- **State Management**: ValueNotifier for reactive UI
- **Architecture**: Clean separation of concerns

## Project Structure

```
lib/
├── main.dart                 # App entry point with Hive initialization
├── models/                   # Data models
│   ├── category/
│   │   ├── category_model.dart
│   │   └── category_model.g.dart
│   └── transaction/
│       ├── transaction_model.dart
│       └── transaction_model.g.dart
└── screens/                  # UI screens
    ├── home/
    │   ├── screen_home.dart
    │   └── widget/
    │       └── bottom_navigation.dart
    ├── category/
    │   └── screen_category.dart
    └── transaction/
        ├── screen_transation.dart
        └── add_transaction_screen.dart
```

## Getting Started

### Prerequisites
- Flutter SDK 3.8.0 or higher
- Dart SDK 3.0.0 or higher

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Money_management_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate Hive adapters**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## Usage

### Adding Transactions
1. Tap the floating action button (+)
2. Select transaction type (Income/Expense)
3. Enter the amount
4. Choose a category
5. Select the date
6. Add optional notes
7. Tap "Save Transaction"

### Managing Categories
1. Navigate to the Categories tab
2. Switch between Income and Expense categories
3. Edit categories by tapping the edit icon
4. Delete categories by tapping the delete icon

### Viewing Transactions
1. The main screen shows all transactions
2. Summary cards display balance, income, and expenses
3. Transactions are sorted by date (newest first)
4. Analytics and charts also reflect newest-first sorting
5. Long press to delete transactions

## Default Categories

### Income Categories
- Salary
- Freelance
- Investment
- Business
- Other Income

### Expense Categories
- Food & Dining
- Transportation
- Shopping
- Entertainment
- Healthcare
- Education
- Bills & Utilities
- Other Expenses

## Database Schema

### Transaction Model
```dart
class Transaction {
  String id;           // Unique identifier
  String categoryId;   // Reference to category
  double amount;       // Positive for income, negative for expense
  DateTime date;       // Transaction date
}
```

### Category Model
```dart
class Category {
  String id;           // Unique identifier
  String name;         // Category name
  bool isDeleted;      // Soft delete flag
  CategoryType type;   // Income or Expense
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure code quality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the repository.

---

**Built with ❤️ using Flutter and Hive**
