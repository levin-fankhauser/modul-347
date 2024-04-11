const express = require('express');
const { MongoClient, ObjectId } = require('mongodb');
const path = require('path');

const app = express();
const port = 3000;

// MongoDB-Verbindung herstellen
const uri = 'mongodb://localhost:27017';
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
let db;

async function connectToMongo() {
    try {
        await client.connect();
        db = client.db('notes_app'); // Neue Datenbank "notes_app"
        console.log('Connected to MongoDB');
    } catch (err) {
        console.error('Error connecting to MongoDB', err);
    }
}

connectToMongo();

// Middleware für JSON-Parser
app.use(express.json());

// Statische Dateien servieren
app.use(express.static(path.join(__dirname, 'public')));

// Routen definieren
app.get('/notes', async (req, res) => {
    const notes = await db.collection('notes').find({}).toArray();
    res.json(notes);
});

app.post('/notes', async (req, res) => {
    const note = req.body;
    await db.collection('notes').insertOne(note);
    res.status(201).send('Note added successfully');
});

app.delete('/notes/:id', async (req, res) => {
    const id = req.params.id;
    try {
        await db.collection('notes').deleteOne({ _id: new ObjectId(id) }); // Verwende 'new' für ObjectId
        res.status(200).send('Note deleted successfully');
    } catch (err) {
        console.error('Error deleting note', err);
        res.status(500).send('Internal server error');
    }
});


// Server starten
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
