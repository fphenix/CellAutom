// Fred Limouzin 2017

class CellAutom {
  int[] state;
  int[] prevstate;
  int rule;
  int len;
  float scl;

  CellAutom (int tl) {
    this.len = tl;
    this.scl = 1.0 * width / tl;
    this.state = new int[len];
    this.prevstate = new int[len];
    this.rule = 13;
    this.init();
  }

  void init () {
    for (int i = 0; i < this.len; i++) {
      this.state[i] = 0;
      this.prevstate[i] = 0;
    }
    this.state[floor(this.len / 2.0)] = 1;
  }

  void setRule(int nbr) {
    this.rule = nbr;
  }

  void curr2prev () {
    for (int i = 0; i < this.len; i++) {
      this.prevstate[i] = this.state[i];
    }
  }

  int wrap (int idx) {
    return (idx < 0) ? this.len+idx : ((idx >= this.len) ? idx-this.len : idx); // wrap around
  }

  void genNextGen () {
    int lookupcase;
    this.curr2prev();
    for (int i = 0; i < this.len; i++) {
      lookupcase  = this.prevstate[wrap(i-1)] << 2;
      lookupcase += this.prevstate[i]         << 1;
      lookupcase += this.prevstate[wrap(i+1)] << 0;
      this.state[i] = (this.rule & (1 << lookupcase)) >> lookupcase;
    }
  }

  void display (int y) {
    noStroke();
    //stroke(127);
    //strokeWeight(0.1);
    for (int i = 0; i < this.len; i++) {
      fill(255 * (1 - this.state[i]));
      rect(floor(i*this.scl), floor(y*this.scl), scl, scl);
    }
    fill(240, 32, 240);
    text("Rule #" + this.rule + "  (click Mouse for Next)", 20, 10);
  }
}