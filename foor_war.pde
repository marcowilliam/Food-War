//global variables
int currentScore = 0;
int score = 0;
int lives = 5;
int highScore = 0;
PImage target;
PImage backGround1;
PImage backGround0;
PImage cloud;
PImage propeller1;
PImage propeller2;
PImage propeller3;
PImage imgType;
int status = 0;
int moveX1 = 0;
int moveX2 = 100;
Food food[] = new Food[4];
Airplane airplane[] = new Airplane[4];
float moveY[] = new float[4];
int count[] = new int[4];

void setup() {

  size(700, 500);
  //loading images
  target = loadImage("img/target.png");
  backGround1 = loadImage("img/backGround0.png");
  backGround0 = loadImage("img/backGround1.png");
  cloud = loadImage("img/cloud.png");
  propeller1 = loadImage("img/propeller1.png");
  propeller2 = loadImage("img/propeller2.png");
  propeller3 = loadImage("img/propeller3.png");
  //creating foods
  food[0] = new Food(105, 60, 60, 0.02, 0);
  food[1] = new Food(205, 230, 230, 0.02, 1);
  food[2] = new Food(375, 110, 110, 0.02, 2);
  food[3] = new Food(505, 330, 330, 0.02, 3);
  //creating airplanes
  airplane[0] = new Airplane(100, 30, 0);
  airplane[1] = new Airplane(200, 200, 0);
  airplane[2] = new Airplane(370, 80, 0);
  airplane[3] = new Airplane(500, 300, 0);
  for (int i=0; i<4; i++) {
    count[i] = 1;
    moveY[i] = 0;
  }
  //chaging the cursor image for a target image
  cursor(target);
}


void draw() {

  if (status==0) {  
    startScreen();
  } else if (status==1) { 
    runGame();
  }

  drawFoods();
  dropFood();
  countLives();
  checkClick();
  checkGameOver();
}

void startScreen() {

  background(backGround0);
  textSize(32);
  fill(0);
  text(highScore, 186, 481);
  text(currentScore, 186, 433);
  fill(255);
  textSize(12);
  noLoop();
}

void runGame() {

  background(backGround1);
  drawClouds();
  airplane[0].drawAirplane();
  airplane[1].drawAirplane(); 
  airplane[2].drawAirplane();
  airplane[3].drawAirplane(); 
  text("Score: " + score, 0, 10);
  text("Lives: " + lives, 655, 10);
  drawFood(food[0]);
  food[0].draw = true;
  if (frameCount>300) {
    drawFood(food[2]);
    food[2].draw = true;
  }
  if (frameCount>1000) {
    drawFood(food[1]);
    food[1].draw = true;
  }
  if (frameCount>2000) {
    drawFood(food[3]);
    food[3].draw = true;
  }
}

void drawFoods() {

  for (int i = 0; i<food.length; i++) { 
    if (food[i].y>500 || food[i].status == false) {
      if (food[i].y>480) {
        food[i].status = true;
        food[i].type = count[i];
        count[i]++;
        moveY[i] = 0;
        food[i].y = food[i].initialY;
        if (count[i]==4)
          count[i] = 0;
      }
    }
  }
}

void dropFood() {

  for (int i = 0; i<food.length; i++) {
    if (food[i].draw == true) {
      moveY[i] = moveY[i] + food[i].velocity;
      food[i].y = food[i].y + moveY[i];
    }
  }
}

void countLives() {

  for (int i=0; i<food.length; i++) {
    if (food[i].y>500 && food[i].draw == true) {
      lives--;
    }
  }
}

void checkGameOver() {

  if (lives==0) {
    highScore = max(highScore, score);
    frameCount = 0;
    currentScore = score;
    score = 0;
    for (int i=0; i<food.length; i++) {
      food[i].y = food[i].initialY;
      food[i].draw = false;
      moveY[i]=0;
    }
    lives = 5;
    status=0;
  }
}
void drawClouds() {

  image(cloud, 313+moveX1, 114, 76, 32);
  image(cloud, 470+moveX1, 38, 181, 76);
  image(cloud, 255+moveX1, 51, 33, 14);
  image(cloud, 78+moveX1, 65, 116, 49);
  image(cloud, 913+moveX2, 114, 76, 32);
  image(cloud, 1070+moveX2, 38, 181, 76);
  image(cloud, 855+moveX2, 51, 33, 14);
  image(cloud, 678+moveX2, 65, 116, 49);

  moveX1--;
  moveX2--;

  if (moveX1 == -700)
    moveX1=650;

  if (moveX2 == -1300)
    moveX2=50;
}

void drawFood(Food food) {

  if (food.type == 0) {
    imgType = loadImage("hamburger.png");
  } else if (food.type == 1) {
    imgType = loadImage("pizza.png");
  } else if (food.type == 2) {
    imgType = loadImage("fries.png");
  } else if (food.type == 3) {
    imgType = loadImage("hotdog.png");
  }
  if (food.status==false)
    imgType = loadImage("nothing.png");


  image(imgType, food.x, food.y);
}

void checkClick() {

  if (mousePressed) {

    for (int i=0; i<4; i++) {
      if (mouseX > food[i].x-5 && mouseX < food[i].x+40 && mouseY > food[i].y-5 && mouseY < food[i].y+40 && food[i].status == true) {
        score = score + food[i].getPoints();
        food[i].status = false;
      }
    }
  }
}

void mousePressed()
{

  if (status==0) {
    status = 1;
    loop();
    redraw();
  }
}

