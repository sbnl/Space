//Copyright Software By Numbers Ltd
#library('sbnl:space');

/**
 * Defines a base type representing a direction.
 */
interface Direction {

  //Direction in degrees is 0 to 359.99 degrees.
  num getDegrees(); //throws DirectionException;

  //Direction in radians is 0.01 to 2 pi
  num getRadians(); //throws DirectionException;

  String asString(String f(Direction direction));

}

//Base type for direction exception
interface DirectionExcepion extends Exception {
}


