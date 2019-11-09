import processing.sound.*; //Need to import processing.sound library to play music
SoundFile file;
float music_rate = 1;
void music() {
  SoundFile file = new SoundFile(this, "rocky.wav"); //Loads song
  file.play(); //Plays song
}

void musicspeed(SoundFile file) { //dead function for now, will increase speed with difficulty
  if (millis()%300 ==0) { //every 3 second
    if (file.isPlaying()) {
      file.pause();
    } else {
      file.play();
    }
  }
}
