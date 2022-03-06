# Team14
## Research Notes App
Developed for Software Hut COM3420 course running in 2020/2021

### Description
Welcome to the Luhmann’s Slip-box Note Taking System. This is a note-taking system inspired by Niklas Luhmann’s method of taking notes, which involves writing ideas down onto cards, and organising and connecting them together in threads that can branch out into a network of interconnected ideas. The main benefits of this note-taking method are that you increase your understanding of the connections between notes, as you have to focus on where the best place is to add a new note so that it fits most appropriately with the already existing notes, which reinforces the connection in your mind.

### Running the Application
To launch the system locally run the following commands from the root of this project directory in a Bash terminal of your choice:
```
bundle install

sudo service postgresql start

sudo systemctl enable postgresql

bundle exec rake db:create

bundle exec rake db:migrate

bundle exec rake db:seed

bundle exec rails s
```

A demo of the application is available at:
https://team14.demo2.hut.shefcompsci.org.uk/ 

### Access for University of Sheffield members only
Users are required to log in with their University of Sheffield credentials in order to benefit from using our note-taking application

### User instructions
A guide on how to use the system can be found in the "Info" section of the application.

