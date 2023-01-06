class Juggler {
  float xpos;
  float ypos;
  float sizeX;
  float sizeY;

  //Juggler constructor
  Juggler (float tempXpos) {
    xpos =  tempXpos;
    ypos = height - 30;
    sizeX = width*2/3;
    sizeY = 40;
  }

  //Moves and displays the juggler object
  //This method accepts no parameters, but does accept mouse input
  //This method returns no values
  void moveAndDisplay() {
    stroke(0);
    xpos = mouseX;
    fill(#5D7D5D);
    rect(xpos, ypos, sizeX, sizeY);
  }
}
