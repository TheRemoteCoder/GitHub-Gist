//@flow

/**
 * Canvas 2D API helper functions.
 *
 * Features
 * - Clear/Reset canvas data.
 * - Simplify translation + rotation.
 * - Draw points, boxes, lines as visual helpers.
 */
class CanvasHelper {
  #optionsDefault = {
    sizes: {
      box: 10,
      point: 1,
      vector: 10,
    },
    colors: {
      box: 'rgba(0, 0, 0, 1)',
      direction: 'rgba(0, 0, 0, 1)',
      point: 'rgba(0, 0, 0, 1)',
      rotation: 'rgba(0, 0, 0, 1)',
    },
  };

  /**
   * HTMLCanvasElement reference.
   */
  #canvas = null;

  /**
   * CanvasRenderingContext2D reference.
   */
  #ctx = null;

  /**
   * Custom drawing styles.
   */
  #options = {};

  /**
   * Constructor
   *
   * @param {Object}      canvas
   * @param {Object|null} options
   */
  constructor(canvas, options) {
    this.#canvas = canvas;
    this.#ctx = canvas.getContext('2d');

    this.#options = {
      ...this.#optionsDefault,
      ...(options ?? {}),
    };
  }

  /**
   * Clear canvas screen.
   * Respect previous drawing context.
   */
  clear() {
    const ctx = this.#ctx;
    const canvas = this.#canvas;

    ctx.save();
    ctx.setTransform(1, 0, 0, 1, 0, 0);
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.restore();
  }

  /**
   * Rotate canvas from translation coordinates.
   * Keep transformation.
   *
   * @param {Number} x     X coordinate.
   * @param {Number} y     Y coordinate.
   * @param {Number} angle Rotation angle in radians.
   */
  translateRotate(x, y, angleRadians) {
    const ctx = this.#ctx;

    ctx.save();
    ctx.translate(x, y);
    ctx.rotate(angleRadians);
  }

  /**
   * Draw box around point.
   *
   * @param {Number} x X coordinate.
   * @param {Number} y Y coordinate.
   */
  drawBox(x, y) {
    const ctx = this.#ctx;
    const options = this.#options;
    const size = options.sizes.box;

    ctx.save();
    ctx.strokeStyle = options.colors.box;
    ctx.strokeRect(x - size / 2, y - size / 2, size, size);
    ctx.restore();
  }

  /**
   * Draw point.
   *
   * @param {Number} x X coordinate.
   * @param {Number} y Y coordinate.
   */
  drawPoint(x, y) {
    const ctx = this.#ctx;
    const options = this.#options;
    const size = options.sizes.point;

    ctx.save();
    ctx.fillStyle = options.colors.point;
    ctx.fillRect(x - size / 2, y - size / 2, size, size);
    ctx.restore();
  }

  /**
   * Draw direction vector.
   *
   * @param {Number} x1 X coordinate (origin).
   * @param {Number} y1 Y coordinate (origin).
   * @param {Number} x2 X coordinate (direction).
   * @param {Number} y2 Y coordinate (direction).
   */
  drawDirectionVector(x1, y1, x2, y2) {
    const ctx = this.#ctx;
    const options = this.#options;
    const lineLength = options.sizes.vector;

    ctx.save();
    ctx.translate(x1, y1);
    ctx.beginPath();

    ctx.strokeStyle = options.colors.direction;
    ctx.moveTo(0, 0);
    ctx.lineTo(x2 * lineLength, y2 * lineLength);

    ctx.stroke();
    ctx.restore();
  }

  /**
   * Draw rotation vector.
   *
   * @param {Number} x     X coordinate.
   * @param {Number} y     Y coordinate.
   * @param {Number} angle Rotation angle in radians.
   */
  drawRotationVector(x, y, angleRadians) {
    const ctx = this.#ctx;
    const options = this.#options;

    ctx.save();
    ctx.translate(x, y);
    ctx.beginPath();

    ctx.rotate(angleRadians);
    ctx.strokeStyle = options.colors.rotation;
    ctx.moveTo(0, 0);
    ctx.lineTo(options.sizes.vector, 0);

    ctx.stroke();
    ctx.restore();
  }
}
