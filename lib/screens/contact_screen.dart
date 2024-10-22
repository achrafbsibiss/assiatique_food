import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal, Colors.teal.shade200],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Contact Information',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(height: 30),
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 200),
                  child: _buildContactCard(
                    icon: Icons.person,
                    title: 'Name',
                    subtitle: 'Achraf Bsibiss',
                  ),
                ),
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 400),
                  child: _buildContactCard(
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'achraf.bsibiss11@gmail.com',
                  ),
                ),
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 600),
                  child: _buildContactCard(
                    icon: Icons.phone,
                    title: 'Phone',
                    subtitle: '+212 6 57 46 64 06',
                  ),
                ),
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 800),
                  child: _buildContactCard(
                    icon: Icons.location_on,
                    title: 'Address',
                    subtitle: 'Casablanca, Morocco',
                  ),
                ),
                SizedBox(height: 30),
                FadeInUp(
                  duration: Duration(milliseconds: 500),
                  delay: Duration(milliseconds: 1000),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Feel free to contact me for any questions or suggestions about the recipes!',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.teal.shade800,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          child: Icon(icon, color: Colors.teal.shade800),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.teal.shade600),
        ),
      ),
    );
  }
}
