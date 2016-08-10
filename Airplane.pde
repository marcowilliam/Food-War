
class Airplane extends Object {

  PImage airplaneImg = loadImage("airplane1.png");

  //Constructor 
  Airplane(float x, float y, float velocity) {
    super( x, y, velocity);
  }

  void drawAirplane() {

    image(airplaneImg, this.x+0, this.y+0, 64, 39);
    if (frameCount%3==0)
      image(propeller1, this.x+50, this.y+15, 1, 12);
    if (frameCount%3==1)
      image(propeller2, this.x+45, this.y+15, 6, 8);
    if (frameCount%3==2)
      image(propeller3, this.x+45, this.y+15, 9, 10);
  }
}

