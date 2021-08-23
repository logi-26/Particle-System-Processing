
class Asteroid {

  // Asteroid location, velocity, and acceleration 
  PVector location, velocity, acceleration;
  float mass;                                          // Mass is tied to size
  float size;                                          // Size of the asteroid
  int maxHealth;                                       // Asteroid maximum health
  int health;                                          // Asteroid current health
  float repelStrength = 100;

  // Asteroid constructor
  Asteroid(PVector asteroidLocation, float asteroidMass, int asteroidHealth) {
    location = asteroidLocation;
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    mass = asteroidMass;
    size = mass*16;
    maxHealth = asteroidHealth;
    health = maxHealth;
  }

  // This function applies a force to the asteroid
  void applyForce(PVector force) {
    PVector newForce = PVector.div(force, mass);        // Divide by mass
    acceleration.add(newForce);                         // Accumulate all forces in acceleration
  }

  // This function Updates the asteroid
  void update() {
    velocity.add(acceleration);                        // Velocity changes according to acceleration
    location.add(velocity);                            // Location changes by velocity
    acceleration.mult(0);                              // Acceleration must be cleared each frame
  }
  
  // This function draws the asteroid
  void display() {
    stroke(255);
    strokeWeight(2);
    fill(255, 200);
    ellipse(location.x, location.y, size, size);
  }
  
  // This function applies a repeller force between the asteroid and any particles
  PVector repel(Particle theParticle) {
    PVector dir = PVector.sub(location,theParticle.location);
    float d = dir.mag();
    dir.normalize();
    d = constrain(d,5,100);
    float force = -1 * repelStrength / (d * d);
    dir.mult(force);
    return dir;
  }
  
  // This function checks if the asteroid has reached the bottom of the screen
  boolean outOfBounds(boolean gameOver) {
    if (location.y >= 840) gameOver = true;          // If the asteroid has reached the bottom of the screen the boolean is set true
    return gameOver;                                 // Returns the boolean
  }
}