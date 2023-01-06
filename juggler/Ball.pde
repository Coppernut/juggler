class Ball {
  float xpos;
  float ypos;
  float radius;
  float speed;
  boolean isMovingDown;
  boolean isMovingRight;
  int colour;

  //Ball constructor
  Ball (float tempXpos, float tempYpos, int tempColour) {
    xpos = tempXpos;
    ypos = tempYpos;
    radius = 10;
    speed = 1;
    isMovingDown = true;
    isMovingRight = setBallDirection();
    colour = tempColour;
  }

  //Draws ball object
  // This method accepts the ball object parameter
  //This method returns no values
  void display(Ball ball) {
    stroke(ball.colour);
    fill(colour);
    circle(ball.xpos, ball.ypos, ball.radius);
    fill(255);
  }

  //Moves ball object
  //This method accepts the ball object parameter
  //This method returns no values, but does update ball object properties 
  void move( Ball ball) {

    //Up and Down movement
    if (ball.ypos >= height) {
      ball.isMovingDown = false;
    } else if (ball.ypos <= 10) {
      ball.isMovingDown = true;
    }

    //Simulates gravity on ball object
    if (ball.isMovingDown == true) {
      ball.ypos = (ball.ypos + speed)*1.05;
    } else {
      ball.ypos = (ball.ypos - speed)*0.95;
    }

    //Right and Left movement
    if (ball.xpos >= width) {
      ball.isMovingRight = false;
    } else if (ball.xpos <= 20) {
      ball.isMovingRight = true;
    }

    if (ball.isMovingRight == true) {
      ball.xpos = ball.xpos + speed;
    } else {
      ball.xpos = ball.xpos - speed;
    }
  }

  //Chooses the starting X direction of the ball object
  // This method accepts no parameters
  //This method returns a value type boolean
  boolean setBallDirection() {
    if (random(10) % 2 ==0) {
      return true;
    } else {
      return false;
    }
  }
}
