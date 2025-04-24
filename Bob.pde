class Bob {
  float x, y;        // Position
  float s;           // Taille
  float speed;       // Vitesse horizontale
  float maxSpeed;    // Vitesse max
  float accel;       // Accélération
  float friction;    // Décélération (inertie)
  color c;           // Couleur du t-shirt
  int leg_position;  // Pour l’animation des jambes

  Bob(float startX, float startY) {
    x = startX;
    y = startY;
    s = 50;
    speed = 0;
    maxSpeed = 6;
    accel = 0.6;
    friction = 0.2;
    c = color(0, 100, 255);
    leg_position = 0;
  }

  void update(boolean left, boolean right) {
    x += speed;
    applyFriction(left, right);
    constrainToScreen();
  }

  void moveLeft() {
    speed -= accel;
    speed = max(speed, -maxSpeed);
  }

  void moveRight() {
    speed += accel;
    speed = min(speed, maxSpeed);
  }

  void applyFriction(boolean left, boolean right) {
    if (!left && !right) {
      if (abs(speed) < friction) {
        speed = 0;
      } else {
        speed -= friction * sign(speed);
      }
    }
  }

  void constrainToScreen() {
    if (x < s/2) {
      x = s/2;
      speed = 0;
    }
    if (x > width - s/2) {
      x = width - s/2;
      speed = 0;
    }
  }

  int sign(float val) {
    return (val > 0) ? 1 : (val < 0 ? -1 : 0);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    
    // tête
    fill(255, 224, 189);
    ellipse(0, -s * 0.5, s * 0.6, s * 0.6);

    // jambes
    fill(0);
    float leg_movement;
    if (keyPressed) {
      leg_position += abs(speed);
      leg_movement = sin(leg_position * 0.1) * s * speed * 0.03;
    } else {
      leg_position = 0;
      leg_movement = 0;
    }
    rect(-s * 0.25, s * 0.25, s * 0.2, s * 0.5 + min(leg_movement, 0));
    rect(s * 0.05, s * 0.25, s * 0.2, s * 0.5 - max(leg_movement, 0));

    // corps
    fill(c);
    rect(-s * 0.5, -s * 0.25, s, s * 0.5);

    // bras
    fill(255, 224, 189);
    rect(-s * 0.7, -s * 0.25, s * 0.2, s * 0.5);
    rect(s * 0.5, -s * 0.25, s * 0.2, s * 0.5);

    popMatrix();
  }
}
