pub struct Canvas {
  pub let width: UInt8;
  pub let height: UInt8;
  pub let pixels: String;

  init(width: UInt8, height: UInt8, pixels: String) {
    self.width = width;
    self.height = height;
    self.pixels = pixels;
  }
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }
  return buffer;
}

pub fun unserializeArrayString(line: String, width: UInt8): [String] {
  let display: [String] = [];
  var _width = Int(width)
  var count = 0;
  var from = 0;
  var to = _width;

  while count < _width {
    let row = line.slice(from: from , upTo: to);
    display.append(row);
    from = from + _width;
    to = to + _width;
    count = count + 1
  }
  return display;
}

pub fun display(canvas: Canvas){
  let topAndBottomFrame = "+-----+"
  let sideFrame = "|"

  let pixelsArray = unserializeArrayString(line: canvas.pixels, width: canvas.width )

  log(topAndBottomFrame)
  for line in pixelsArray {
    log(sideFrame.concat(line).concat(sideFrame))
  }
  log(topAndBottomFrame)
}


pub fun main() {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]

  let canvasX = Canvas(width: 5, height: 5, pixels: serializeStringArray(pixelsX))

  display(canvas: canvasX)
}

    "*   * * * *  * * *   *"