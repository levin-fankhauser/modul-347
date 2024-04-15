#!/bin/bash

mongo mongodb://localhost:27017/notes_app <<EOF

# Füge Demodaten ein
db.notes.insertMany([
  { name: "Einkaufsliste", content: "Brot \nMilch \nNutella" },
  { name: "ToDos", content: "Hunde füttern \nGassi gehen \nPfoten putzen" }
]);

EOF
