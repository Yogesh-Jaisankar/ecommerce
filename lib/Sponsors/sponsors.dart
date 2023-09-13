import 'package:ecommerce/Sponsors/sponsor_item.dart';
import 'package:flutter/material.dart';

class Sponsors extends StatefulWidget {
  const Sponsors({super.key});

  @override
  State<Sponsors> createState() => _SponsorsState();
}

class _SponsorsState extends State<Sponsors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Sponsors",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SponsorItem()),
                  );
                },
                color: Colors.indigoAccent,
                child: Text(
                  "Add Sponsor Item",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Image.asset("assets/images/shoe.png"),
                title: Text("Description"),
                subtitle: Text("price"),
                trailing: GestureDetector(
                  onTap: () {
                    print("Deleted");
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Image.asset("assets/images/shoe.png"),
                title: Text("Description"),
                subtitle: Text("price"),
                trailing: GestureDetector(
                  onTap: () {
                    print("Deleted");
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Image.asset("assets/images/shoe.png"),
                title: Text("Description"),
                subtitle: Text("price"),
                trailing: GestureDetector(
                  onTap: () {
                    print("Deleted");
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Image.asset("assets/images/shoe.png"),
                title: Text("Description"),
                subtitle: Text("price"),
                trailing: GestureDetector(
                  onTap: () {
                    print("Deleted");
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Image.asset("assets/images/shoe.png"),
                title: Text("Description"),
                subtitle: Text("price"),
                trailing: GestureDetector(
                  onTap: () {
                    print("Deleted");
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Image.asset("assets/images/shoe.png"),
                title: Text("Description"),
                subtitle: Text("price"),
                trailing: GestureDetector(
                  onTap: () {
                    print("Deleted");
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset("assets/images/shoe.png"),
                ),
                title: Text("Description"),
                subtitle: Text("price"),
                trailing: GestureDetector(
                  onTap: () {
                    print("Deleted");
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
