class SplashScreenBall {
  float xpos;
  float ypos;
  float radius;
  String layer;
  int colour;

  // SplashScreenBall constructor
  SplashScreenBall( float tempXpos, String tempLayer, int tempColour ) {
    xpos = tempXpos;
    ypos = 0; // always start at top of window
    layer = tempLayer;
    radius = getBallRadius(layer);
    colour = tempColour;
  }

  // Display SplashScreenBall
  //This method accepts the SplashScreenBall object parameter
  //This method returns no values
  void display( SplashScreenBall splashScreenBall ) {
    stroke(0);
    fill(splashScreenBall.colour);
    circle( splashScreenBall.xpos, splashScreenBall.ypos, splashScreenBall.radius );
  }

  //Move SplashScreenBall
  //This method accepts the SplashScreenBall object parameter
  //This method returns no values, but updates splashScreenBall properties
  void move( SplashScreenBall splashScreenBall ) {
    float ballVelocity = 1;

    if ( splashScreenBall.layer == "foreground" ) {
      splashScreenBall.ypos = splashScreenBall.ypos + ballVelocity * 3;  // 3x faster than ballVelocity
    } else if ( splashScreenBall.layer == "midground" ) {
      splashScreenBall.ypos = splashScreenBall.ypos + ballVelocity * 2;  // 2x faster than ballVelocity
    } else {
      splashScreenBall.ypos = splashScreenBall.ypos + ballVelocity;
    }
  }

  // Get ball radius value depending on layer
  // This method accepts the ballLayer string parameter
  //This method returns a float value that represents the ball radius based on the layer it is on
  float getBallRadius( String ballLayer ) {
    float smallRadius = 10;

    if ( ballLayer == "foreground" ) {  
      return smallRadius * 3;  // 3x bigger than small ball
    } else if ( ballLayer == "midground" ) {
      return smallRadius * 2;  // 2x bigger than small ball
    } else {
      return smallRadius;
    }
  }
}
