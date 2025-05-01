class StrikeHard extends Strike {
  boolean branched = false;
  float branch_x, branch_y;

  StrikeHard(float _x1, float _y1, int _strike_speed) {
    super(_x1, _y1, _strike_speed);
  }

  @Override
  void display() {
    super.display();
    if (!branched && current_y > (y1 + y2) / 2) {
      branched = true;
      branch_x = current_x + random(-50, 50);
      branch_y = current_y + random(30, 60);
    }
    if (branched) {
      stroke(200, 200, 0);
      line(current_x, current_y, branch_x, branch_y);
    }
  }
}
