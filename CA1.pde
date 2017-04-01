// Fred Limouzin 2017

CellAutom ca;

int nbcells = 63;
int nbgens  = 96;
int ruleid  = 57;

void setup () {
  size(520, 800);
  ca = new CellAutom(nbcells);
}

void draw () {
  ca.setRule(ruleid);
  ca.init();
  for (int y = 0; y < nbgens; y++) {
    ca.display(y);
    ca.genNextGen();
  }
}

void mousePressed () {
  if (mouseButton == RIGHT) {
    ruleid = (ruleid == 0) ? 255 : (ruleid - 1);
  } else {
    ruleid = (ruleid + 1) % 256;
  }
}