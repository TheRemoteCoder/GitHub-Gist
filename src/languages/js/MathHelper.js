//@flow

/**
 * Extended math functionality.
 *
 * Features
 * - Distance calculation
 * - Angle calculation and conversion
 */
class MathHelper {
  /**
   * Constructor
   */
  constructor() {}

  /**
   * Calculate distance between points (2D).
   *
   * @param  {Number} x1 X coordinate - Point 1.
   * @param  {Number} y1 Y coordinate - Point 1.
   * @param  {Number} x2 X coordinate - Point 2.
   * @param  {Number} y2 Y coordinate - Point 2.
   * @return {Number}    Distance between points.
   */
  getDistance(x1, y1, x2, y2) {
    return Math.hypot(x2 - x1, y2 - y1);
  }

  /**
   * Get angle in radians from points (2D).
   *
   * @param  {Number} x1 X coordinate - Point 1.
   * @param  {Number} y1 Y coordinate - Point 1.
   * @param  {Number} x2 X coordinate - Point 2.
   * @param  {Number} y2 Y coordinate - Point 2.
   * @return {Number}    New angle in radians.
   */
  getAngleRad(x1, x2, y1, y2) {
    return Math.atan2(y1 - y2, x1 - x2);
  }

  /**
   * Get X coordinate from angle and scale.
   *
   * @param  {Number} angleRadians Angle in radians.
   * @param  {Number} scale        Scale (e.g. vector size).
   * @return {Number}              X coordinate.
   */
  getXFromAngle(angleRadians, scale) {
    return Math.sin(angleRadians) * scale;
  }

  /**
   * Get Y coordinate from angle and scale.
   *
   * @param  {Number} angleRadians Angle in radians.
   * @param  {Number} scale        Scale (e.g. vector size).
   * @return {Number}              Y coordinate.
   */
  getYFromAngle(angleRadians, scale) {
    return Math.cos(angleRadians) * scale * -1;
  }

  /**
   * Convert angle from degrees to radians.
   *
   * @param  {Number} angleDegrees Angle in degrees.
   * @return {Number}              Angle in radians.
   */
  convertDegToRad(angleDegrees) {
    return (angleDegrees * Math.PI) / 180;
  }

  /**
   * Convert angle from radians to degrees.
   *
   * @param  {Number} angleRadians Angle in radians.
   * @return {Number}              Angle in degrees.
   */
  convertRadToDeg(angleRadians) {
    return (angleRadians * 180) / Math.PI;
  }

  /**
   * Normalize angle in degrees between 0-360°.
   *
   * @param  {Number} angleDegrees Angle in degrees.
   * @return {Number}              Normalized angle in degrees.
   */
  normalizeDeg(angleDegrees) {
    if (angleDegrees > 360) {
      angleDegrees -= 360;
    }

    return angleDegrees;
  }
}
