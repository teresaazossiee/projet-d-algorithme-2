class Level {
  Bob bob;
  Strike strike;
  int score;
  int highscore;
  int strikeSpeed;
  int levelIndex;

  // Constructeur par défaut
  Level() {
    levelIndex = 1; // Niveau par défaut
    bob = new Bob(width / 2, height - 100);
    strikeSpeed = 10;
    reset();
  }

  // Permet de changer de niveau dynamiquement
  void setLevel(int index) {
    levelIndex = index;
    score = 0;
    reset();
  }

  // Réinitialise uniquement le strike
  void reset() {
    if (levelIndex == 3) {
      strike = new StrikeHard(random(width), 0, strikeSpeed);
    } else {
      strike = new Strike(random(width), 0, strikeSpeed);
    }
  }

  void update(boolean leftPressed, boolean rightPressed) {
    bob.update(leftPressed, rightPressed);
    strike.update();

    if (strike.finished()) {
      score++;
      if (score > highscore) highscore = score;
      reset();
    }

    if (strike.hits(bob)) {
      score = 0;
      reset();
    }
  }

  void display() {
    background(0);
    fill(255);
    textSize(20);
    text("Score : " + score, 10, 25);
    text("Highscore : " + highscore, 10, 50);
    bob.display();
    strike.display();
  }

  void moveBobLeft() {
    bob.moveLeft();
  }

  void moveBobRight() {
    bob.moveRight();
  }
}
