#!/bin/bash

# Verbindung zur MongoDB-Datenbank herstellen und Demodaten einfügen
mongo <<EOF

# Datenbank auswählen
use notes_app

# Füge Demodaten ein
db.notes.insertMany([
  { name: "Einkaufsliste", content: "Brot \nMilch \nNutella" },
  { name: "ToDos", content: "Hunde füttern \nGassi gehen \nPfoten putzen" }
]);

EOF
