import processing.sound.*; //Need to import processing.sound library to play music
SoundFile file;
float music_rate = 1;
int play;
void music(float speed, int play) { //Plays music
  if (play  == 1) {
    SoundFile file = new SoundFile(this, "rocky.wav"); //Loads song
    file.rate(speed);
    file.play();
  } else {
    if (file.isPlaying()) {
      file.stop();
    }
  }
}
