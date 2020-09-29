/**
 * General game engine helper and basic math functionality.
 * Set a stage object reference before using any of the methods.
 */
package com
{
  import flash.display.MovieClip;
  import flash.display.Stage;

  public class $
  {
    /** @public Stage */
    public static var stageRef:Stage;

    /** @public uint */
    public static var precision:uint = 3; // Decimal places - 0-20


    // ------------------------------------------------------------------------------------------------------------------- Random operations

    /**
     * Create random number in specified range.
     * The max. value will be auto incremented
     * when using floor instead of optional round.
     *
     * Example for max. value:
     * Math.floor(Math.random() * 41) + 10 = 50
     *
     * @param   min     Minimum number.
     * @param   max     Maximum number.
     * @param   round   Round instead of floor.
     * @return  Number
     */
    public static function rand (min:Number, max:Number = Infinity, round:Boolean = false):Number
    {
      var rnd;

      max = round ? max : max += 1;
      rnd = Math.random() * max;

      return round
        ? Math.round(rnd) + min
        : Math.floor(rnd) + min;
    }

    /**
     * Calculate a random number value between a specified range.
     * Precision can be used to cut of some decimal places.
     *
     * @todo    This is an untested source. Should be the same as in 'rand()'
     * @param   min        Minimum number.
     * @param   max        Maximum number.
     * @param   precision  Number decimal place precision.
     * @return  Number
     */
    public static function randPrecise (min:Number, max:Number, precision:Number = 3):Number
    {
      var rnd:Number = min + Math.random() * (max - min);

      return (precision > -1)
        ? Number(rnd.toFixed(precision))
        : rnd;
    }


    // -------------------------------------------------------------------------------------------------------------------- Array operations

    /**
     * Get a random array index and return its number.
     *
     * @param   arr    Array to retrieve random value from.
     * @return  mixed
     */
    public static function randArrayIndex (arr:Array):*
    {
      return arr[Math.round(Math.random() * (arr.length - 1))];
    }

    /**
     * Check if specific value exists in array and return its index position or -1.
     *
     * @param   search  Any value to search for.
     * @param   arr     Array to search.
     * @return  int
     */
    public static function arrayContains (search:*, arr:Array):int
    {
      var count:uint = arr.length,
          i:uint     = 0;

      for (; i < count; i ++) {
        if (arr[i] == search) {
          return i;
        }
      }

      return -1;
    }

    /**
     * Return maximum value out of an number array.
     *
     * @param   arr    Array with numbers.
     * @return  mixed
     */
    public static function arrayMin (arr:Array):*
    {
      var min:*      = arr[0],
          count:uint = arr.length,
          i:uint     = 0;

      for (; i < count; i ++) {
        if (arr[i] < min) {
          min = arr[i];
        }
      }

      return min;
    }

    /**
     * Return maximum value out of an number array.
     *
     * @param   arr    Array with numbers.
     * @return  mixed
     */
    public static function arrayMax (arr:Array):*
    {
      var max:*    = arr[0],
        count:uint = arr.length,
        i:uint   = 0;

      for (; i < count; i ++) {
        if (arr[i] > max) {
          max = arr[i];
        }
      }

      return max;
    }


    // ---------------------------------------------------------------------------------------------------------------------- Stage handling

    /**
     * Remove existing Clip from stage and mark it for Garbage Collection (optional).
     *
     * @param   mc       Clip to remove from stage.
     * @param   gc       Mark clip for removal by Garbage Collector.
     * @return  Boolean
     */
    public static function remove (mc:MovieClip, gc:Boolean = false):Boolean
    {
      if (stageRef.contains(mc)) {
        stageRef.removeChild(mc);

        if (gc) {
          mc = null;
        }

        return true;
      }

      return false;
    }

    /**
     * Check if object has left stage on either x or y.
     * Object size may be added in parameter.
     *
     * @param   x        Current objects x-position.
     * @param   y        Current objects y-position.
     * @return  Boolean
     */
    public static function hasLeftStage (x:Number, y:Number):Boolean
    {
      return hasLeftStageX(x) || hasLeftStageY(y);
    }

    /**
     * Check if object has left stage on x.
     * Object size may be added in parameter.
     *
     * @param   x        Current objects x-position.
     * @return  Boolean
     */
    public static function hasLeftStageX (x:Number):Boolean
    {
      return (x < 0 || x > stageRef.stageWidth);
    }

    /**
     * Check if object has left stage on y.
     * Object size may be added in parameter.
     *
     * @param   y        Current objects y-position.
     * @return  Boolean
     */
    public static function hasLeftStageY (y:Number):Boolean
    {
      return (y < 0 || y > stageRef.stageHeight);
    }


    // -------------------------------------------------------------------------------------------------------------- Math - Angle, position

    /**
     * Set target angle depending on source position.
     *
     * @param   x       Source x-position.
     * @param   y       Source y-position.
     * @return  Number
     */
    public static function setAngle (x:Number, y:Number):Number
    {
      var angle:Number;

      y  *= -1;
      angle = Math.atan(y / x) / (Math.PI / 180);

      if (x < 0) {
        angle += 180;
      }

      if (x >= 0 && y < 0) {
        angle += 360;
      }

      return (angle * -1) + 90;
    }

    /**
     * Get x-position based on rotation and speed.
     *
     * @param   mc      Get this clips rotation.
     * @param   speed   Object speed.
     * @return  Number
     */
    public static function getPosX (mc:MovieClip, speed:Number = 1):Number
    {
      return Math.sin(mc.rotation * (Math.PI / 180)) * speed;
    }

    /**
     * Get y-position based on rotation and speed.
     *
     * @param   mc      Clip to get rotation from.
     * @param   speed   Object speed.
     * @return  Number
     */
    public static function getPosY (mc:MovieClip, speed:Number = 1):Number
    {
      return Math.cos(mc.rotation * (Math.PI / 180)) * speed * -1;
    }


    // ----------------------------------------------------------------------------------------------------------------- Following

    /**
     * Clip follows mouse cursor with optional easing.
     *
     * @param  mcSource      Mouse following clip.
     * @param  rotateSource  If to rotate source clip.
     * @param  speed         Movement speed for easing.
     */
    public static function followMouse (mcSource:MovieClip, rotateSource:Boolean = false, speed:Number = 1)
    {
      if (rotateSource){
        mcSource.rotation = Math.atan2(
          stageRef.mouseY - mcSource.y,
          stageRef.mouseX - mcSource.x
          ) * 180 / Math.PI
        ;
      }

      mcSource.x -= (mcSource.x - stageRef.mouseX) / speed;
      mcSource.y -= (mcSource.y - stageRef.mouseY) / speed;
    }

    /**
     * Clip follows target object with optional easing.
     *
     * @param  mcSource      Target following clip.
     * @param  mcTarget      Target leads source clip.
     * @param  rotateSource  If to rotate source| clip.
     * @param  speed         Movement speed for easing.
     */
    public static function followTarget (mcSource:MovieClip, mcTarget:MovieClip, rotateSource:Boolean = false, speed:Number = 1)
    {
      if (rotateSource) {
        mcSource.rotation = Math.atan2(
          mcTarget.y - mcSource.y,
          mcTarget.x - mcSource.x
          ) * 180 / Math.PI
        ;
      }

      mcSource.x -= (mcSource.x - mcTarget.x) / speed;
      mcSource.y -= (mcSource.y - mcTarget.y) / speed;
    }
  }
}
