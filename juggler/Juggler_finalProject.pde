// Requires following to be done
// 1. Click Sketch > Import Library... > Add Library
// 2. Install the Sound 2.3.1 Library 
import processing.sound.*;
SoundFile boing;
SoundFile cheer;
SoundFile boo;

//Images
PImage gameOverImage;
PImage backgroundImage;

//Variables
ArrayList<Ball> balls;
Juggler juggler;
int score = 0;
int currentScore = 0;
int highScore = 0;
boolean displaySplashScreen = true;
boolean isGameOver = false;
boolean playerCheer = false; 
int darkGrey = #323232;

// ball spawn timer variables
ArrayList<SplashScreenBall> splashScreenBalls;
float timer;
float maxObjectSpawnTime = 2000; // Max spawn time is 2 seconds

//Intializes program
void setup() {
  size(600, 700);
  ellipseMode(RADIUS);
  rectMode(CENTER);

  //"Comedic Boing, A.wav" by InspectorJ (www.jshaw.co.uk) of Freesound.org
  boing = new SoundFile(this, "comedic-boing-a.wav");

  //"Cheer crowd" by Johanneskristjansson: https://freesound.org/s/371339/
  cheer = new SoundFile(this, "cheer-crowd.mp3");

  // "Crowds: Boo 01.wav" by tim.kahn: https://freesound.org/s/336997/
  boo = new SoundFile(this, "boo-01.wav");

  //Made by Lily Pilon
  gameOverImage = loadImage("GameOverScreenBall.png");

  //Reference: https://steamcommunity.com/sharedfiles/filedetails/?id=1921008205
  backgroundImage = loadImage("CityScape.gif");
  backgroundImage.resize(width, height);

  balls = new ArrayList<Ball>();  // initialize balls arrayList
  balls.add(new Ball(random(width), 20, getRandomColour() )); //Add first ball

  juggler = new Juggler(width/2);  // initialize the juggler

  splashScreenBalls = new ArrayList<SplashScreenBall>(); // initialize splashScreenBalls arrayList
  timer = millis();  // start timer
}

//Runs the program
//This method accepts no parameters
// This method returns no values
void draw() {
  background(darkGrey);

  // Display start screen and else if mousePressed start game
  if (displaySplashScreen == true) {
    showSplashScreen();
  } else {
    if (playerCheer == true) {
      cheer.play(); //plays the cheer sound when the game begins
      playerCheer = false;
    }
    image(backgroundImage, 0, 0);
    fill(255);
    text("Score: " + score, width-115, 40);

    // Increment through balls array and check displyed ball objects for the following properties
    for (int i = 0; i < balls.size(); i++) {
      Ball ball = balls.get(i); 
      ball.display(ball);
      ball.move(ball);

      //If ball has hit Juggler add +1 to score and play sound
      if (canBallBeJuggled(ball, juggler)== true) {
        if (isBallJuggled(ball, juggler)== true) {
          ball.isMovingDown = false;
          boing.play();
          score++;
          addNewBall(score);
        }
      }

      juggler.moveAndDisplay();

      // Gameover
      if (ball.ypos >= height) {
        gameOver();
      }
    }
  }
}

//Is the ball within the y position of the Juggler
// Accepts two parameters the first is the current ball object, the second is the juggler object
// Returns a value type boolean
boolean canBallBeJuggled(Ball ball, Juggler juggler) {
  if ((ball.ypos >= (juggler.ypos - juggler.sizeY/2) &&  ball.ypos <= (juggler.ypos + juggler.sizeY/2)) ) {
    return true;
  } else {
    return false;
  }
}

//Checks if the ball is within the x position of the Juggler
// Accepts two parameters the first is the current ball object, the second is the juggler object
// Returns a value type boolean
boolean isBallJuggled(Ball ball, Juggler juggler) {
  if ((ball.xpos >= juggler.xpos - juggler.sizeX/2)&&(ball.xpos <= juggler.xpos + juggler.sizeX/2)) {
    return true;
  } else {
    return false;
  }
}

//Add new ball every +10 score
// This method accepts the score int as a parameter
// This method returns no values, but can add a ball object to the global balls array
void addNewBall(int score) {
  if (score % 10 == 0) {
    balls.add(new Ball(random(width*0.2, width*0.8), 20, getRandomColour())); //edited from random(width)to be slightly less random as I noticed I would often get the same end score(29,62)
  }
}

//Display start splash, displays balls in the arraylist, removes splashScreenBalls when 
//they leave the bottom of the window, displays splash screen text
//This method requires no parameters
// This method returns no values, however it does update global variables
void showSplashScreen() {
  background(darkGrey);

  String layer; // parallax layer
  int colour; // colour of object
  float randomXPos; // random object x position
  float randomWaitInMillis; // random spawn wait time

  // spawn on random timer
  randomWaitInMillis = random(maxObjectSpawnTime);

  // when spawn timer exceeded add a new object
  if ( (timer + randomWaitInMillis) <= millis() ) {
    layer = getRandomLayer();  // spawn object at a random layer
    randomXPos = random(width); // spawn object at a random x-coordinate
    colour = getRandomColour(); // spawn object with random colour

    splashScreenBalls.add( new SplashScreenBall( randomXPos, layer, colour) );
    timer = millis(); // reset spawn timer
  }

  // display balls in arrayList
  for ( int i = 0; i < splashScreenBalls.size(); i++ ) {
    SplashScreenBall splashScreenBall = splashScreenBalls.get(i);
    splashScreenBall.display( splashScreenBall );
    splashScreenBall.move( splashScreenBall ); // increment ball position for next re-draw

    // remove balls when they leave the bottom of window
    if ( splashScreenBall.ypos > height ) {
      splashScreenBalls.remove(i);
    }
  }

  //Splash Screen Text
  fill(70);
  rect(317, 370, 450, 170); //box for instructions 
  fill(255);
  String instructions  = "How to play: Move the cursor to move the Juggler left and right. Bounce the balls off the Juggler to keep them in the air and increase your score. Be careful not to drop any.";
  text(instructions, 320, 600, 440, 600);
  fill(70); //box colour
  rect(300, 220, 200, 110); //box for the score text
  rect(290, 590, 220, 50); //box for the " click to start" text
  fill(255);
  text("Score: "+currentScore, 225, 150 +50);
  text("High Score: "+highScore, 225, 150+100);
  textSize(30);
  text("click to start", 200, 600);

  //Special font and title text
  PFont titleFont;
  titleFont = loadFont("Bauhaus93-48.vlw"); 
  textFont(titleFont, 100);
  text("Juggler", 150, 110);
  textSize(20); //reset rest of text size

  //Reset the font and size rest of the text
  PFont font;
  font = loadFont("LucidaSans-60.vlw");
  textFont(font, 23);
}

//Displays gameover screen, records high score, and resets game
//This method requires no parameters
// This method returns no values, however it does update global variables
void gameOver() {
  isGameOver = true;
  boo.play(); //plays boo sound when gameover
  balls.clear(); // clear balls array
  displaySplashScreen = true;
  background(darkGrey);
  gameOverImage.resize(300, 300);
  image(gameOverImage, 150, 200);
  fill(70);
  rect(290, 590, 270, 50); //box for the " click to start" text
  fill(255); //set text colour
  textSize(80);
  text("GAME OVER", 70, 110);
  textSize(30);
  text("click to continue", 170, 600);
  noLoop();
  if (score > highScore) { // check to see if new highscore
    highScore = score;
  }
  // reset scores
  currentScore = score;
  score = 0;
  addNewBall(score);  // initialize array for next game
}

//If the mouse is clicked on the start splash screen begin game
//If mouse is clicked on the end screen display start splash screen
//This method requires no parameters
// This method returns no values, however it does update global variables
void mousePressed() {
  if (displaySplashScreen == true) { // exit Splash Screen
    playerCheer = true;
    displaySplashScreen = false;
  }
  if (isGameOver == true) {  // exit Game Over screen
    isGameOver = false;
    loop();
    displaySplashScreen = true;
  }
}

// Get random Layer for the new object off on an array of created layers
//This method requires no parameters
//Returns layer as a string
//Splash Screen Methods
String getRandomLayer() {
  String layers[] = { "foreground", "midground", "background" };
  int randomLayerSelection;

  randomLayerSelection = int(random(layers.length));

  return layers[randomLayerSelection];
}

//Picks a random colour off an array of preselected colour options
//This method requires no parameters
// Returns colour as an int
//Get random colour
int getRandomColour() {
  int colours[] = {#f9A834, #40BAA4, #B4cf68, #EC5064, #8564F5, #FFA979, #FB3C43};
  int randomColourSelection;

  randomColourSelection = int(random(colours.length));
  return colours[randomColourSelection];
}
