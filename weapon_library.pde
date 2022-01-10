//super(threshold, speed, size, type of bullet, bullet colour);

class FingerGun extends Weapon {
  FingerGun() {
    super(FINGER_THRESH, FINGER_SPEED, FINGER_SIZE, "finger gun", white);
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class PowerGun extends Weapon {
  PowerGun() {
    super(POWER_THRESH, POWER_SPEED, POWER_SIZE, "normal", gold);
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Bomb extends Weapon {
  Bomb() {
   super(BOMB_THRESH, BOMB_SPEED, BOMB_SIZE, "normal", grey);
  }
}
