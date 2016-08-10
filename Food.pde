
class Food extends Object {

  int type;
  int points;
  float initialY;
  boolean draw = false;

    //Constructor 
  Food(float x, float y, float initialY_, float velocity, int type_) 
    { 
      super(x, y, velocity);
      type = type_;
      initialY = initialY_;
    }

    int getPoints() {
      if (type == 0) {
        points = 1;
      } else if (type == 1) {
        points = 2;
      } else if (type == 2) {
        points = 3;
      } else if (type == 3) {
        points = 4;
      }
      return points;
    }
  }

