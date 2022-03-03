
import processing.sound.*;
//ya
//timer
//coolness

SoundFile file;
int score = 0;
int health = 100;
int state = 0;
int dist;
String boom_moo = "moo_boom.mp3";
String AudioName = "game_song.mp3";
String Path;

PImage zomb;
PImage img;
PImage boom;
boolean[] keys;
int bulletx[] = new int[300];
int bullety[] = new int[300];
boolean bulletvisible[] = new boolean[300];
int currentbullet = 0;
int personx = 100;
int persony = height /2;
int personspeed = 3;

int zombiex[] = new int[1000];
int zombiey[] = new int[1000];
boolean zombievisible[] = new boolean[1000];
int zombiespeed = 2;
int zombiesize = 75;
int bulletspeed = 40;
void generatebullets(){
  for(int i = 0; i < 300; i = i + 1 ){
    bulletx[i] = -50;
    bullety[i] = -50;
    bulletvisible[i] = false;
  }
}
void generatezombies(){
  for (int i = 0; i < 1000; i = i + 1){
    zombiex[i] = int(random(width, 20000));
    zombiey[i] = int(random(0, height));
    zombievisible[i] = true;
  }
}
void redrawgamefield(){
  for(int i = 0; i < 300; i = i + 1){
    if (bulletvisible[i] == true){
    fill(255,0,0);
    rect(bulletx[i], bullety[i], 8,3);
    }
  }
  
   for(int i = 0; i < 1000; i = i + 1){
    if (zombievisible[i] == true){
    fill(0,255,0);
    image(zomb, zombiex[i], zombiey[i], zombiesize, zombiesize);
  }
}
fill(255);
image(img, personx, persony, 50, 50);
}
int distance(int x1, int y1, int x2, int y2){
  return round(sqrt(pow((x1-x2), 2)+pow((y1-y2), 2)));

}
void CheckCollision(){
  //some code 
  for(int i = 0; i <1000; i++){ //for some zombies
    for(int j = 0; j <300; j++){ //for every bullet
      dist = distance(zombiex[i], zombiey[i], bulletx[j], bullety[j]);
      if(bulletvisible[j] == true && zombievisible[i] == true && dist < zombiesize){
          image(boom, zombiex[i], zombiey[i], 50, 50);
            Path = sketchPath(boom_moo);
            file = new SoundFile(this, Path);
            file.play();
          zombievisible[i] = false;
          bulletvisible[j] = false;
          score = score + 1;
          
      }
  }
  }
} 
void Checkzombie(){
  //some code 
  for(int i = 0; i <1000; i++){ //for some zombies
      dist = distance(zombiex[i], zombiey[i], personx, persony);
      if(zombievisible[i] == true && dist < 50){
          zombievisible[i] = false;
          health = health - 20;
          
      }
  }
  }
void StartScreen() {
  rectMode(CENTER);
    background(255, 0,0 );
      //text("press any key", 400, 300);
  background(0.0);

  float r1 = map(mouseX, 0, width, 0, height);
  float r2 = height-r1;
  
  fill(r1);
  rect(width/2 + r1/2, height/2, r1, r1);
  
  fill(r2);
  rect(width/2 - r2/2, height/2, r2, r2);
      if (keyPressed == true){
          state = 1;
      }
}
void endscreen(){
  background(0,255,0);
  
}
void healthloss(){
  if (personx <= 0 || persony >=height || persony <= 0){
                                health -= 1;
}
}
void healthgain(){
  if (personx >= width){
    health += 1;
  }
}
void setup(){
  size(800, 600); 
  background(255,0,0);
  Path = sketchPath(AudioName);
  file = new SoundFile(this, Path);
  file.play();
  zomb = loadImage("zombie_dude.png");
  img = loadImage("dude.png"); 
  boom = loadImage("boom_boy.png");
  keys = new boolean[5];
  keys[0] = false;
  keys[1] = false;
  keys[2] = false;
  keys[3] = false;
  keys[4] = false;
  generatebullets();
  generatezombies();
}
void draw(){
  background(255, 0, 0);
  if (state == 0 ){
    background(255, 0, 0);
      StartScreen();
  }
  if (state == 1 ){
        
  
  background(0, 0, 255);
  text("score:", 750, 15);
  
  text(score, 750, 50);
  text("health", 750, 75);
  text(health, 750, 100);
  //i just got the world record 500 kills and -100000 health in like a few minutes im rich
  redrawgamefield();
  healthgain();
  healthloss();
  //image(img, personx, persony, 50, 50);
  if(keys[0] && personx >= 0){//left
    personx = personx-personspeed;
  }
  if(keys[1] && personx <= width){//right
    personx = personx+personspeed;
  } 
  if(keys[2] && persony <= height){
    persony = persony+personspeed;
  } 
  if(keys[3] && persony >= 0){
    persony = persony-personspeed;
  }   
  if(keys[4]){
    bulletx[currentbullet] = personx;
    bullety[currentbullet] = persony;
    bulletvisible[currentbullet] = true;
    currentbullet = currentbullet + 1;
    if (currentbullet == 300){
    currentbullet = 0;
    }  
  }
  for (int i = 0; i < 300; i ++){
  if (bulletvisible[i] == true && bulletx[i] < width){
    bulletx[i] += bulletspeed;
  }
    if (bulletx[i] >= width){
      bulletvisible[i] = false;
    }
  }
  
  for (int i = 0; i < 1000; i ++){
  if (zombievisible[i] == true){
    zombiex[i] -= zombiespeed;
  }
  }
  CheckCollision();
  Checkzombie();
  if (health <0 ){
    state = 2;
  }
}
if (state == 2){
    endscreen();
 }
}
void keyPressed() {
// move the ship left / right with the arrow keys
if (key==CODED && keyCode==LEFT) keys[0]=true;//left
if (key==CODED && keyCode==RIGHT) keys[1]=true;//right
if (key==CODED && keyCode==DOWN) keys[2]=true;//down
if (key==CODED && keyCode==UP) keys[3]=true;//up
// shoot bullets when SPACE BAR is pressed
if (key==' ') keys[4]=true;
}

void keyReleased() {
if (key==CODED && keyCode==LEFT) keys[0]=false;//left
if (key==CODED && keyCode==RIGHT) keys[1]=false;//right
if (key==CODED && keyCode==DOWN) keys[2]=false;//down
if (key==CODED && keyCode==UP) keys[3]=false;//up
if (key==' ') keys[4]=false;
}
