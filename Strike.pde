class Strike {
    float x1, y1, x2, y2, current_x, current_y;
    float progress;
    int strike_speed;
    Strike nextStrike;

    Strike(float _x1, float _y1, int _strike_speed) {
        strike_speed = _strike_speed; // suggested speed : 10
        x1 = _x1;
        y1 = _y1;
        y2 = random(0.95,0.85)*height;
        x2 = random(max(0, x1-(height-y1)),min(width, x1+(height-y1)));
        progress = 0;
        nextStrike = null;

        current_x = x1;
        current_y = y1;
    }

    void update() {
        if (nextStrike == null) {
            progress();
            if (random(1) < 0.05) {
                nextStrike = new Strike(current_x, current_y, strike_speed);
            }
        } else {
            nextStrike.update();
        }
    }

    void progress() {
        current_y += strike_speed;
        current_y = constrain(current_y, 0, y2);
        current_x = x2 + (x1 - x2) * (current_y - y2) / (y1 - y2);
    }

    void display() {
        stroke(255, 255, 0);
        strokeWeight(3);
        line(x1, y1, current_x, current_y);
        noStroke();

        if (nextStrike != null) {nextStrike.display();}
    }

    boolean finished() {
        return current_y == y2 || (nextStrike != null && nextStrike.finished());
    }

    boolean hits(Bob bob) {
        return (dist(bob.x, bob.y, current_x, current_y) < 0.7*bob.s) || (nextStrike != null && nextStrike.hits(bob));
    }
}
