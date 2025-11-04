# 💰 Expense Splitter

<div align="center">

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-005C84?style=for-the-badge&logo=mysql&logoColor=white)
![Servlet](https://img.shields.io/badge/Servlet-FF6C37?style=for-the-badge&logo=java&logoColor=white)

**A robust web application for tracking and splitting shared expenses among group members**

[Features](#features) • [Demo](#demo) • [Installation](#installation) • [Usage](#usage) • [Technologies](#technologies) • [Contributing](#contributing)

</div>

---

## 📋 Table of Contents

- [About](#about)
- [Features](#features)
- [Demo](#demo)
- [Technologies](#technologies)
- [Architecture](#architecture)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Database Schema](#database-schema)
- [API Endpoints](#api-endpoints)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## 🎯 About

**Expense Splitter** is a full-stack Java web application designed to simplify the process of tracking and splitting expenses among groups. Whether you're managing household expenses, splitting bills with roommates, or tracking group trip costs, this application provides an intuitive interface to manage shared finances effortlessly.

### Why Expense Splitter?

- ✅ **Fair Distribution**: Automatically calculates who owes whom
- ✅ **Real-time Balances**: See up-to-date balance summaries instantly
- ✅ **Expense Tracking**: Keep detailed records of all expenses
- ✅ **Member Management**: Add and manage group members easily
- ✅ **Professional UI**: Modern, responsive design for all devices

---

## ✨ Features

### Core Functionality

- 👥 **Member Management**
  - Add multiple group members
  - View all active members
  - Remove members when needed

- 💵 **Expense Tracking**
  - Record expenses with descriptions
  - Specify who paid for each expense
  - Track expense history with timestamps
  - View all expenses in an organized list

- 📊 **Balance Calculator**
  - Automatic calculation of per-person share
  - Real-time balance updates
  - Clear visualization of who owes whom
  - Smart settlement recommendations

- 🔄 **Data Management**
  - Clear all data with one click
  - Safe database operations
  - Transaction history preservation

### Technical Features

- 🔒 **Secure Configuration**: Environment-based database credentials
- 🎨 **Responsive Design**: Mobile-friendly interface
- ⚡ **Fast Performance**: Optimized database queries
- 🛡️ **Error Handling**: Robust exception management
- 📱 **Modern UI**: Clean and intuitive user experience

---

## 🎬 Demo

### Main Dashboard
The home page provides quick access to all features with an elegant, modern interface.

### Expense Tracking
Add expenses with detailed information including description, amount, and payer selection.

### Balance Summary
View comprehensive balance calculations showing who owes money and who should receive payments.

---

## 🛠️ Technologies

### Backend
- **Java** - Core programming language
- **JSP (JavaServer Pages)** - Dynamic web page generation
- **Servlets** - HTTP request handling
- **JDBC** - Database connectivity
- **MySQL** - Relational database management

### Frontend
- **HTML5** - Markup structure
- **CSS3** - Styling and animations
- **JavaScript** - Client-side interactivity
- **Font Awesome** - Icon library
- **Google Fonts** - Typography (Poppins)

### Architecture Patterns
- **MVC (Model-View-Controller)** - Application structure
- **DAO (Data Access Object)** - Database abstraction layer
- **Service Layer** - Business logic separation
- **Singleton Pattern** - Database connection management

---

## 🏗️ Architecture

```
expense-splitter/
│
├── src/main/java/
│   ├── dao/                    # Data Access Objects
│   │   ├── ExpenseDAO.java     # Expense database operations
│   │   └── MemberDAO.java      # Member database operations
│   │
│   ├── model/                  # Data Models
│   │   ├── Expense.java        # Expense entity
│   │   └── Member.java         # Member entity
│   │
│   ├── service/                # Business Logic
│   │   └── BalanceCalculator.java  # Balance calculation service
│   │
│   ├── servlet/                # Controllers
│   │   ├── AddExpenseServlet.java
│   │   ├── AddMemberServlet.java
│   │   └── ClearDatabaseServlet.java
│   │
│   └── utility/                # Utilities
│       ├── DBConnection.java   # Database connection
│       └── EnvLoader.java      # Environment variable loader
│
├── src/main/webapp/            # Web Resources
│   ├── index.jsp               # Main dashboard
│   ├── addMember.jsp           # Add member page
│   ├── addExpense.jsp          # Add expense page
│   ├── summary.jsp             # Balance summary page
│   └── WEB-INF/
│       └── web.xml             # Servlet configuration
│
├── .env                        # Environment variables (not in git)
├── .env.example                # Environment template
├── .gitignore                  # Git ignore rules
└── README.md                   # This file
```

### Design Patterns Used

1. **MVC Pattern**: Separates business logic, data, and presentation
2. **DAO Pattern**: Abstracts database operations
3. **Singleton Pattern**: Manages database connections
4. **Service Layer Pattern**: Encapsulates business logic

---

## 🚀 Installation

### Prerequisites

Before you begin, ensure you have the following installed:

- ☕ **Java JDK** 8 or higher
- 🗄️ **MySQL** 5.7 or higher
- 🌐 **Apache Tomcat** 9.x or higher
- 🛠️ **Maven** (optional, for dependency management)
- 💻 **IDE** (Eclipse, IntelliJ IDEA, or VS Code)

### Step 1: Clone the Repository

```bash
git clone https://github.com/yourusername/expense-splitter.git
cd expense-splitter
```

### Step 2: Set Up MySQL Database

1. **Start MySQL Server**

2. **Create the Database**

```sql
CREATE DATABASE expense_splitter;
USE expense_splitter;
```

3. **Create the Tables**

```sql
-- Members Table
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Expenses Table
CREATE TABLE expenses (
    expense_id INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(255) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    paid_by INT NOT NULL,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (paid_by) REFERENCES members(member_id)
);
```

### Step 3: Configure Environment Variables

1. **Copy the environment template**

```bash
cp .env.example .env
```

2. **Edit the `.env` file with your MySQL credentials**

```properties
DB_URL=jdbc:mysql://localhost:3306/expense_splitter
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_DRIVER=com.mysql.cj.jdbc.Driver
```

> ⚠️ **Important**: Never commit the `.env` file to version control!

### Step 4: Add MySQL Connector

Download the MySQL Connector JAR and place it in:
- `src/main/webapp/WEB-INF/lib/` (for web deployment)
- OR add to your Tomcat `lib` folder

Download from: [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/)

### Step 5: Deploy to Tomcat

#### Option A: Using IDE (Eclipse/IntelliJ)

1. Import the project as a Dynamic Web Project
2. Configure Tomcat server in your IDE
3. Deploy and run the application

#### Option B: Manual Deployment

1. Build the WAR file:
   ```bash
   jar -cvf ExpenseSplitter.war *
   ```

2. Copy to Tomcat webapps:
   ```bash
   cp ExpenseSplitter.war /path/to/tomcat/webapps/
   ```

3. Start Tomcat:
   ```bash
   ./catalina.sh run  # Linux/Mac
   catalina.bat run   # Windows
   ```

### Step 6: Access the Application

Open your browser and navigate to:
```
http://localhost:8080/Expense_Splitter_Final/
```

---

## ⚙️ Configuration

### Environment Variables

The application uses environment variables for secure configuration. All sensitive data is stored in the `.env` file.

| Variable | Description | Example |
|----------|-------------|---------|
| `DB_URL` | JDBC connection URL | `jdbc:mysql://localhost:3306/expense_splitter` |
| `DB_USER` | Database username | `root` |
| `DB_PASSWORD` | Database password | `your_password` |
| `DB_DRIVER` | JDBC driver class | `com.mysql.cj.jdbc.Driver` |

### Database Configuration

- **Connection Pool**: Single connection with connection reuse
- **Character Encoding**: UTF-8
- **Timezone**: System default
- **Auto-reconnect**: Enabled

For more details, see [ENV_SETUP.md](ENV_SETUP.md)

---

## 📖 Usage

### Adding Members

1. Navigate to **"Add Member"** from the main dashboard
2. Enter the member's name
3. Click **"Add Member"**
4. Member will appear in the members list

### Recording Expenses

1. Click on **"Add Expense"** 
2. Fill in the expense details:
   - Description (e.g., "Dinner at restaurant")
   - Amount (e.g., 150.00)
   - Select who paid from the dropdown
3. Click **"Add Expense"**
4. Expense will be recorded and balances updated

### Viewing Balance Summary

1. Click on **"View Summary"**
2. See the breakdown:
   - Total expenses
   - Per-person share
   - Individual balances
   - Who owes money (in red)
   - Who should receive money (in green)

### Clearing Data

1. Go to the main dashboard
2. Click **"Clear All Data"**
3. Confirm the action
4. All members and expenses will be removed

---

## 🗄️ Database Schema

### Members Table

| Column | Type | Description |
|--------|------|-------------|
| `member_id` | INT (PK, AUTO_INCREMENT) | Unique member identifier |
| `member_name` | VARCHAR(100) | Member's name |
| `date_added` | TIMESTAMP | When member was added |

### Expenses Table

| Column | Type | Description |
|--------|------|-------------|
| `expense_id` | INT (PK, AUTO_INCREMENT) | Unique expense identifier |
| `description` | VARCHAR(255) | Expense description |
| `amount` | DECIMAL(10, 2) | Expense amount |
| `paid_by` | INT (FK) | Reference to member who paid |
| `date_added` | TIMESTAMP | When expense was recorded |

### Relationships

- `expenses.paid_by` → `members.member_id` (Many-to-One)

---

## 🔌 API Endpoints

### Servlets

| Servlet | URL Pattern | Method | Description |
|---------|-------------|--------|-------------|
| `AddMemberServlet` | `/AddMemberServlet` | POST | Add a new member |
| `AddExpenseServlet` | `/AddExpenseServlet` | POST | Record a new expense |
| `ClearDatabaseServlet` | `/ClearDatabaseServlet` | POST | Clear all data |

### DAO Methods

#### MemberDAO
- `getAllMembers()` - Retrieve all members
- `addMember(Member)` - Add new member
- `deleteMember(int)` - Remove member
- `getMemberById(int)` - Get member by ID

#### ExpenseDAO
- `getAllExpenses()` - Retrieve all expenses
- `addExpense(Expense)` - Add new expense
- `getTotalExpenses()` - Calculate total expenses
- `getTotalPaidByMember(int)` - Get amount paid by member

---

## 📸 Screenshots

### Dashboard
> Main landing page with quick access to all features

### Add Member
> Simple form to add new group members

### Add Expense
> Record expenses with details and payer selection

### Balance Summary
> Comprehensive view of who owes whom with clear visualization

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

### How to Contribute

1. **Fork the repository**
   ```bash
   git clone https://github.com/yourusername/expense-splitter.git
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. **Make your changes**
   - Write clean, documented code
   - Follow existing code style
   - Test your changes thoroughly

4. **Commit your changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```

5. **Push to the branch**
   ```bash
   git push origin feature/AmazingFeature
   ```

6. **Open a Pull Request**

### Development Guidelines

- ✅ Follow Java naming conventions
- ✅ Add comments for complex logic
- ✅ Test all database operations
- ✅ Ensure responsive design
- ✅ Update documentation for new features

### Code Style

- **Indentation**: 4 spaces
- **Braces**: K&R style
- **Naming**: camelCase for variables, PascalCase for classes
- **Comments**: Javadoc for public methods

---

## 🐛 Bug Reports

Found a bug? Please open an issue with:

- Description of the bug
- Steps to reproduce
- Expected behavior
- Actual behavior
- Screenshots (if applicable)
- Environment details (OS, Java version, MySQL version)

---

## 💡 Feature Requests

Have an idea? Open an issue with the `enhancement` label:

- Clear description of the feature
- Use cases and benefits
- Possible implementation approach

---

## 📝 Future Enhancements

- [ ] User authentication and authorization
- [ ] Multiple group support
- [ ] Export data to CSV/PDF
- [ ] Mobile app version
- [ ] Email notifications
- [ ] Recurring expenses
- [ ] Expense categories
- [ ] Advanced analytics and charts
- [ ] Split expenses by percentage
- [ ] Multi-currency support

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2025 Expense Splitter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions...
```

---

## 👨‍💻 Author

**Your Name**

- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- **Font Awesome** - For the beautiful icons
- **Google Fonts** - For the Poppins font family
- **MySQL** - For robust database management
- **Apache Tomcat** - For servlet container
- **Stack Overflow Community** - For troubleshooting help

---

## 📚 Resources

- [Java Documentation](https://docs.oracle.com/en/java/)
- [JSP Tutorial](https://www.tutorialspoint.com/jsp/index.htm)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Tomcat Documentation](https://tomcat.apache.org/tomcat-9.0-doc/)

---

## 🔧 Troubleshooting

### Common Issues

**Issue**: Database connection failed
```
Solution: Check your .env file credentials and ensure MySQL is running
```

**Issue**: ClassNotFoundException for MySQL driver
```
Solution: Add mysql-connector-java.jar to WEB-INF/lib or Tomcat lib folder
```

**Issue**: 404 error when accessing the app
```
Solution: Check the context path in your Tomcat configuration
```

**Issue**: Expenses not showing up
```
Solution: Ensure you have added members before adding expenses
```

For more help, please open an issue on GitHub.

---

## 📊 Project Stats

- **Lines of Code**: ~2000+
- **Files**: 15+ Java files, 4 JSP pages
- **Database Tables**: 2
- **Development Time**: 2 weeks
- **Status**: Active Development

---

<div align="center">

### ⭐ Star this repository if you find it helpful!

**Made with ❤️ using Java, JSP, and MySQL**

[Back to Top](#-expense-splitter)

</div>
