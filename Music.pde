import processing.sound.*; //Need to import processing.sound library to play music
SoundFile file;
float music_rate = 1;
int play;
void music(float speed, int play) { //Plays music
  play = 0; // set to 1 to enable music
  if (play  == 1) {
    SoundFile file = new SoundFile(this, "rocky.wav"); //Loads song
    file.rate(speed);
    file.play();
  }
}
