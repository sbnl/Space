//Copyright Software By Numbers Ltd

#import('dart:html');
#import('dart:math');
#import('./packages/unittest/unittest.dart');
#import('Point.dart');
#import('SimplePoint.dart');
#import('Direction.dart');
#import('SimpleDirection.dart');
#import('SISurface.dart');
#import('SimpleSIDrawingSurface.dart');
#import('SimpleVector2D.dart');
#import('Vector.dart');


void main() {
  SpaceTest spaceTest = new SpaceTest();
  //spaceTest.testPoint();
  //spaceTest.testDirection();
  //spaceTest.testDraw();
  //spaceTest.testVector();
  //spaceTest.testDrawNegativeY();
  spaceTest.testSine();
}

class SpaceTest {

  void testPoint() {
    test("SimplePoint", () {
      Point2D point = new SimplePoint(10,10);
      expect(point.magnitude()).equals(sqrt(200));
    });
  }

  void testDirection() {
    test("SimpleDirection from a bearing in degs  0",(){
      Direction direction = new SimpleDirection.fromDegs(0.0);
      expect(direction.getDegrees()).equals(0);
    });
    test("SimpleDirection from point - 45 degs",(){
      Point2D point = new SimplePoint(20,20);
      Direction direction = new SimpleDirection.fromPoint(point);
      expect(direction.getDegrees()).approxEquals(45);
    });
    test("SimpleDirection from point  135 degs",(){
      Point2D point = new SimplePoint(20,-20);
      Direction direction = new SimpleDirection.fromPoint(point);
      expect(direction.getDegrees()).approxEquals(135);
    });
    test("SimpleDirection from point  225 degs",(){
      Point2D point = new SimplePoint(-20,-20);
      Direction direction = new SimpleDirection.fromPoint(point);
      expect(direction.getDegrees()).approxEquals(225);
    });
    test("SimpleDirection from point  315 degs",(){
      Point2D point = new SimplePoint(-20,20);
      Direction direction = new SimpleDirection.fromPoint(point);
      expect(direction.getDegrees()).approxEquals(315);
    });
    test("SimpleDirection from point  90 degs",(){
      Point2D point = new SimplePoint(20,0);
      Direction direction = new SimpleDirection.fromPoint(point);
      expect(direction.getDegrees()).approxEquals(90);
    });

    //45 degrees as a string
    Point2D point = new SimplePoint(20.0,20.0);
    Direction direction = new SimpleDirection.fromPoint(point);
    print(direction.asString((Direction aDirection) {
      return "Degrees : ${aDirection.getDegrees()} Rads : ${aDirection.getRadians()}";
    }));

  }

  void testDraw() {

    /*
     * These functions scale in the x and y direction.
     */
    ScaleUnitsToPixels scaleXMetersToPixels = (units) {
      //scale factor along the x axis is 30:1 30 pixels per meter
      return (units * 30).toInt();
    };

    ScaleUnitsToPixels scaleYMetersToPixels = (units) {
      //scale factor along the y axis is 50:1 50 pixels per meter
      return (units * 50).toInt();
    };

    ScalePixelsToUnits scaleXPixelsToUnits = (pixels) {
      return pixels / 30;
    };

    ScalePixelsToUnits scaleYPixelsToUnits = (pixels) {
      return pixels / 50.0;
    };

    //create the surface
    SIDrawingSurface siSurface = new SimpleSIDrawingSurface.fromCanvas(document.query("#canvas1"));
    siSurface.setScaleUnitsToPixels(scaleXMetersToPixels, scaleYMetersToPixels);
    siSurface.setScalePixelsToUnits(scaleXPixelsToUnits, scaleYPixelsToUnits);
    //outline
    siSurface.drawOutline();

    //draw some graph paper bars

    //draw a simple straight line (2m, 2m) to (5m, 5m)
    siSurface.drawLine(new SimplePoint(2,4), new SimplePoint(5,5));
    siSurface.drawLine(new SimplePoint(0.5,2), new SimplePoint(5,0.5));
    siSurface.drawLine(new SimplePoint(0,0), new SimplePoint(5,5));
    //draw an x and y axis
    siSurface.drawXAxis(new SimplePoint(0,0), 1.0, 0.0);
    siSurface.drawYAxis(new SimplePoint(0,0), 1.0, 0.0,"m/s");
  }



  testVector() {
    Vector2D vector = new SimpleVector2D.fromMagAndDir(22.0, new SimpleDirection.fromDegs(45));
    print(vector.asString((Vector2D aVector) {
      return "Magnitude : ${vector.getMagnitude()} Direction :${ vector.getDirection().asString(directionAsString)}";
    }));
  }

  void testDrawNegativeY() {
    /*
     * These functions scale in the x and y direction.
     */
    ScaleUnitsToPixels scaleXMetersToPixels = (units) {
      //scale factor along the x axis is 30:1 30 pixels per meter
      return (units * 30).toInt();
    };

    ScaleUnitsToPixels scaleYMetersToPixels = (units) {
      //scale factor along the y axis is 50:1 50 pixels per meter
      return (units * 50).toInt();
    };

    ScalePixelsToUnits scaleXPixelsToUnits = (pixels) {
      return pixels / 30;
    };

    ScalePixelsToUnits scaleYPixelsToUnits = (pixels) {
      return pixels / 50.0;
    };

    //create the surface
    SIDrawingSurface siSurface = new SimpleSIDrawingSurface.fromCanvas(document.query("#canvas1"));
    siSurface.setScaleUnitsToPixels(scaleXMetersToPixels, scaleYMetersToPixels);
    siSurface.setScalePixelsToUnits(scaleXPixelsToUnits, scaleYPixelsToUnits);
    //outline
    siSurface.drawOutline();
    siSurface.drawXAxis(new SimplePoint(0.0,0.0), 1, 0,'deg');
    siSurface.drawYAxis(new SimplePoint(0.0,5.0), 5, 0, '');
    //siSurface.drawYAxis(new SimplePoint(0.0,5.0), -5.0, 0, '');
  }

  void testSine() {
    /*
     * These functions scale in the x and y direction.
     */
    ScaleUnitsToPixels scaleXMetersToPixels = (units) {
      //scale factor along the x axis is 30:1 30 pixels per meter
      return (units * 10).toInt();
    };

    ScaleUnitsToPixels scaleYMetersToPixels = (units) {
      //scale factor along the y axis is 50:1 50 pixels per meter
      return (units * 50).toInt();
    };

    ScalePixelsToUnits scaleXPixelsToUnits = (pixels) {
      return pixels / 10;
    };

    ScalePixelsToUnits scaleYPixelsToUnits = (pixels) {
      return pixels / 50.0;
    };

    //create the surface
    SIDrawingSurface siSurface = new SimpleSIDrawingSurface.fromCanvas(document.query("#canvas1"));
    siSurface.setScaleUnitsToPixels(scaleXMetersToPixels, scaleYMetersToPixels);
    siSurface.setScalePixelsToUnits(scaleXPixelsToUnits, scaleYPixelsToUnits);
    //outline
    siSurface.drawOutline();
    siSurface.drawXAxis(new SimplePoint(0.0,0.0), 5, 0,'degs');
    siSurface.drawYAxis(new SimplePoint(0.0,0.0), 5.0, 0, '');

    Point2D plotPoint1 = new SimplePoint(0,1.0);
    Point2D plotPoint2;
    int count = 50;
    int i = 0;
    while(i<count) {
      plotPoint2 = new SimplePoint(i, sin(i*2*PI/count) + 1.0);
      siSurface.drawLine(plotPoint1, plotPoint2);
      plotPoint1 = plotPoint2;
      i++;
    }
    plotPoint1 = new SimplePoint(0,1.0);
    i=0;
    while(i<count) {
      plotPoint2 = new SimplePoint(i, cos(i*2*PI/count) + 1.0);
      siSurface.drawLine(plotPoint1, plotPoint2);
      plotPoint1 = plotPoint2;
      i++;
    }
    plotPoint1 = new SimplePoint(0,1.0);
    i=0;
    while(i<count) {
      plotPoint2 = new SimplePoint(i, tan(i*2*PI/count) + 1.0);
      siSurface.drawLine(plotPoint1, plotPoint2);
      plotPoint1 = plotPoint2;
      i++;
    }

  }


  String directionAsString(Direction direction) {
    return "Direction degs : ${direction.getDegrees()} Direction rads : ${direction.getRadians()}";
  }

}

