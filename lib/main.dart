import 'package:flutter/material.dart';

User initUser = User();

void main() {
  runApp(MaterialApp(
    home: Home(),
    routes: {
      '/List': (context) => Expenses(),
    },
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        backgroundColor: Colors.amberAccent[200],
        centerTitle: true,
        title: const Text('Budget Tracker'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  color: Colors.amberAccent[200],
                  size: 120.0,
                ),
              ),
              Text(
                'Welcome back,\n' + initUser.userName,
                style: TextStyle(
                  color: Colors.amberAccent[200],
                  fontWeight: FontWeight.w600,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/List');
                },
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.amberAccent[200]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total Balance \t \t' + initUser.Balance.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 22,
                        )),
                    const SizedBox(width: 30),
                    const Icon(
                      Icons.arrow_circle_down_outlined,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}

class expense {
  expense(String name, int val) {
    expenseName = name;
    expenseVal = val;
  }

  String expenseName = "";
  int expenseVal = 0;
}

class User {
  String userName = "User";
  int Balance = 50000;

  List<expense> expenses = [
    expense('Grocery', -2000),
    expense('TV', -140000),
    expense('Salary', 500000),
    expense('Dining', -5600)
  ];
}

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  Widget expenseTemplate(String enxpenseName, int expenseVal) {
    dynamic bgColor = Colors.red;
    if (expenseVal > 0) {
      bgColor = Colors.green;
    } else
      expenseVal = -expenseVal;

    return Container(
      width: 600,
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          color: bgColor[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                enxpenseName,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: bgColor[400],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: <Widget>[
                  const SizedBox(height: 50),
                  Text('$expenseVal',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: bgColor[700],
                      )),
                ],
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amberAccent[200],
        title: const Text('Expenses List'),
      ),
      body: Center(
        child: Column(
          children: initUser.expenses
              .map((exPense) =>
                  expenseTemplate(exPense.expenseName, exPense.expenseVal))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent[200],
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('Add expense'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Expense Name',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Money spent',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
