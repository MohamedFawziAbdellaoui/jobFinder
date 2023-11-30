const MongoClient = require('mongodb').MongoClient;

// MongoDB connection URI
const uri = 'mongodb://127.0.0.1:27017';

// Database and collection names
const dbName = 'jobfinder';
const collectionName = 'user';

const addresses = [
  {
    address: '123 Main Street',
    city: 'Tunis',
    country: 'Tunisia',
    postalcode: '1000',
  },
  {
    address: '456 Elm Street',
    city: 'Sfax',
    country: 'Tunisia',
    postalcode: '3000',
  },
  {
    address: '789 Oak Street',
    city: 'Sousse',
    country: 'Tunisia',
    postalcode: '5000',
  },
];

// Connect to MongoDB
MongoClient.connect(
  uri,
  { useNewUrlParser: true, useUnifiedTopology: true },
  (err, client) => {
    if (err) {
      console.error('Error connecting to MongoDB:', err);
      return;
    }

    const db = client.db(dbName);
    const collection = db.collection(collectionName);

    // Retrieve all user documents
    collection.find({}).toArray((err, users) => {
      if (err) {
        console.error('Error retrieving users:', err);
        client.close();
        return;
      }

      // Update each user document with a new address
      users.forEach((user, index) => {
        const userId = user._id; // Assuming your user documents have an '_id' field

        // Use the corresponding address for each user
        const addressToUpdate = addresses[index];

        // Update user document with new address fields
        collection.updateOne(
          { _id: userId },
          { $set: { address: addressToUpdate } },
          (err, result) => {
            if (err) {
              console.error('Error updating user:', err);
            } else {
              console.log(`User with ID ${userId} updated successfully.`);
            }
          },
        );
      });

      // Close the MongoDB connection
      client.close();
    });
  },
);
