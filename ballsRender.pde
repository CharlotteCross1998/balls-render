ArrayList<Ball> balls;

final int MAX_DISTANCE = 100;
final int MAX_BALLS    = 50;

class Ball
{
   float positionX, positionY, velocityX, velocityY, ballStrokeWeight;
   Ball(float x, float y)
   {
      positionX = x;
      positionY = y;
      velocityX = random(-1, 1); //Initial starting velocity
      velocityY = random(-1, 1);
      ballStrokeWeight = random(1.5, 5);
   }
   void Render()
   {
      stroke(255);
      strokeWeight(ballStrokeWeight);
      point(positionX, positionY);
   }
   void Update()
   {
      positionX += velocityX;
      positionY += velocityY;
      //Collision detection
      if(positionX <= 0 || positionX >= width) velocityX = -velocityX; //Reverse velocity
      if(positionY <= 0 || positionY >= height) velocityY = -velocityY;
      //Find closest and second closest ball
      Ball closestBall = null, secondClosestBall = null;
      float closestDist = 9999, secondClosestDist = 9999;
      for(Ball ball : balls) //Loop through all the balls
      {
         if(ball == this) continue; //Don't check ourselves
         float distance = dist(positionX, positionY, ball.positionX, ball.positionY);
         if(distance < closestDist)
         {
            closestDist = distance;
            closestBall = ball;
         }
         else if(distance < secondClosestDist)
         {
            secondClosestDist = distance;
            secondClosestBall = ball;
         }
         if(secondClosestBall != null)
         {
           //This is the maximum distance for 3 balls intersecting to create a triangle.
           //We check the second one because if the second one is close, the first one will be too.
           if(secondClosestDist < MAX_DISTANCE) 
           {
              strokeWeight(2);
              fill(61, 61, 61);
              triangle(positionX, positionY, closestBall.positionX, closestBall.positionY, secondClosestBall.positionX, secondClosestBall.positionY);
           }
         }
      }
   }
}

void setup()
{
   size(1280, 720, P2D); //Size must be the first line of code within setup
   balls = new ArrayList<Ball>();
   for(int i = 0; i < MAX_BALLS; ++i)
   {
       balls.add(new Ball(random(width), random(height)));
   }
}

void draw()
{
   background(20, 19, 33);
   for(Ball ball : balls)
   {
      ball.Render();
      ball.Update();
   }
}
