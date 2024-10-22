import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VotingForm extends StatefulWidget {
  @override
  _VotingFormState createState() => _VotingFormState();
}

class _VotingFormState extends State<VotingForm> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String regNumber = '';
  String selectedHeadBoy = '';
  String selectedHeadGirl = '';
  String selectedViceHeadBoy = '';
  String selectedViceHeadGirl = '';
  String selectedSportPresident = '';
  String selectedJinnahHouseCaptain = '';
  String selectedIqbalHouseCaptain = '';

  List<String> headBoyOptions = ['Abdullah Munir', 'Taha Khan', 'Sameer Khan'];
  List<String> headGirlOptions = ['Rameen Eizel', 'Abeer Fatima', 'Mehreen Memon'];
  List<String> viceHeadBoyOptions = ['Nafey Ali', 'Sulaiman Khan', 'Muhammed Ibrahim'];
  List<String> viceHeadGirlOptions = ['Hafsa', 'Ayesha Shehzad', 'Mehak Mahmood'];
  List<String> sportPresidentOptions = ['Aqsa Asim', 'Shuja Haider', 'Abdul Hadi Khan'];
  List<String> jinnahHouseCaptainOptions = ['Syed Tayyab Shah', 'Ayesha Malik', 'Syed Haider Abbas'];
  List<String> iqbalHouseCaptainOptions = ['Saifan Hassan', 'Talha Alam', 'Mustafa Nouman'];

  FirebaseFirestore firestore = FirebaseFirestore.instance; // Firestore instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text('Voting System'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.blue[50],
                  contentPadding: EdgeInsets.all(16),
                ),
                onSaved: (value) => name = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),  // Add spacing between fields
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Registration Number',
                  labelStyle: TextStyle(fontSize: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.blue[50],
                  contentPadding: EdgeInsets.all(16),
                ),
                onSaved: (value) => regNumber = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your registration number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Head Boy selection
              Text('Select a Head Boy', style: TextStyle(fontWeight: FontWeight.bold)),
              for (var option in headBoyOptions)
                RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedHeadBoy,
                  onChanged: (value) {
                    setState(() {
                      selectedHeadBoy = value!;
                    });
                  },
                ),

              // Head Girl selection
              Text('Select a Head Girl', style: TextStyle(fontWeight: FontWeight.bold)),
              for (var option in headGirlOptions)
                RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedHeadGirl,
                  onChanged: (value) {
                    setState(() {
                      selectedHeadGirl = value!;
                    });
                  },
                ),

              // Vice Head Boy selection
              Text('Select a Vice Head Boy', style: TextStyle(fontWeight: FontWeight.bold)),
              for (var option in viceHeadBoyOptions)
                RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedViceHeadBoy,
                  onChanged: (value) {
                    setState(() {
                      selectedViceHeadBoy = value!;
                    });
                  },
                ),

              // Vice Head Girl selection
              Text('Select a Vice Head Girl', style: TextStyle(fontWeight: FontWeight.bold)),
              for (var option in viceHeadGirlOptions)
                RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedViceHeadGirl,
                  onChanged: (value) {
                    setState(() {
                      selectedViceHeadGirl = value!;
                    });
                  },
                ),

              // Sport President selection
              Text('Select a Sport President', style: TextStyle(fontWeight: FontWeight.bold)),
              for (var option in sportPresidentOptions)
                RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedSportPresident,
                  onChanged: (value) {
                    setState(() {
                      selectedSportPresident = value!;
                    });
                  },
                ),

              // Jinnah House Captain selection
              Text('Select a Jinnah House Captain', style: TextStyle(fontWeight: FontWeight.bold)),
              for (var option in jinnahHouseCaptainOptions)
                RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedJinnahHouseCaptain,
                  onChanged: (value) {
                    setState(() {
                      selectedJinnahHouseCaptain = value!;
                    });
                  },
                ),

              // Iqbal House Captain selection
              Text('Select an Iqbal House Captain', style: TextStyle(fontWeight: FontWeight.bold)),
              for (var option in iqbalHouseCaptainOptions)
                RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: selectedIqbalHouseCaptain,
                  onChanged: (value) {
                    setState(() {
                      selectedIqbalHouseCaptain = value!;
                    });
                  },
                ),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Prepare the vote data to be stored in Firestore
                    Map<String, dynamic> voteData = {
                      'name': name,
                      'regNumber': regNumber,
                      'selectedHeadBoy': selectedHeadBoy,
                      'selectedHeadGirl': selectedHeadGirl,
                      'selectedViceHeadBoy': selectedViceHeadBoy,
                      'selectedViceHeadGirl': selectedViceHeadGirl,
                      'selectedSportPresident': selectedSportPresident,
                      'selectedJinnahHouseCaptain': selectedJinnahHouseCaptain,
                      'selectedIqbalHouseCaptain': selectedIqbalHouseCaptain,
                    };

                    try {
                      // Store the data in Firestore
                      await firestore.collection('votes').add(voteData);

                      // Show success message
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Your vote has been submitted successfully!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Clear form fields
                                  setState(() {
                                    name = '';
                                    regNumber = '';
                                    selectedHeadBoy = '';
                                    selectedHeadGirl = '';
                                    selectedViceHeadBoy = '';
                                    selectedViceHeadGirl = '';
                                    selectedSportPresident = '';
                                    selectedJinnahHouseCaptain = '';
                                    selectedIqbalHouseCaptain = '';
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      // Handle error
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to submit your vote. Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}