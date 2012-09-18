//Copyright Software By Numbers Ltd
#library('sbnl:space');
#import('Point.dart');


/**
 * Models a piece of paper that allows SI units (well meters at the moment)
 * to be drawn onto it.
 */
abstract class  SIDrawingSurface  {


  abstract void drawOutline([bool yes]);

  //Draws a line between two points
  //@throws SIDrawingSurfaceException if the scale functions have not been set
  abstract void drawLine(Point2D point1, Point2D point2);

  /*
   * Draws an x and y axis
   *@throws SIDrawingSurfaceException if the scale functions have not been set
   */
  abstract void drawXAxis(Point2D origin, num graticuleInterval, num startValue, [String units]);
  abstract void drawYAxis(Point2D origin, num graticuleInterval, num startValue, [String units]);

  /*
   * Draws axis.
   */
  abstract void drawNewXAxis();


  /*
   * These set the scale functions
   */
  abstract void setScaleUnitsToPixels(ScaleUnitsToPixels scaleXUnitsToPixels, ScaleUnitsToPixels scaleYUnitsToPixels);
  abstract void setScalePixelsToUnits(ScalePixelsToUnits scaleXPixelsToUnits, ScalePixelsToUnits scaleYPixelsToUnits);

}

class SIDrawingSurfaceException implements Exception {

}

//scales a pixel count to an si unit quantity
typedef num ScalePixelsToUnits(int pixels);

//scales si units to pixels
typedef int ScaleUnitsToPixels(num unit);

