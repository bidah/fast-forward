pub contract Artist {
  // start new code
  pub resource Collection {
    pub let store: @[Picture];

    init() {
      self.store <- []
    }

    pub fun getCanvasList(): [Artist.Canvas] {
      var canvasList: [Artist.Canvas] = [];

      var index = 0;
      while index < self.store.length {
        canvasList.append(self.store[index].canvas)
        index = index + 1
      }
      return canvasList
    }

    pub fun deposit(picture: @Picture) {
      self.store.append(<- picture)
    }

    destroy() {
      destroy self.store
    }
  }

  pub fun createCollection(): @Collection {
    return <- create Collection()
  }
  // end new code

  pub struct Canvas {

    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String

    init(width: UInt8, height: UInt8, pixels: String) {
      self.width = width
      self.height = height
      self.pixels = pixels
    }
  }

  pub resource Picture {
    pub let canvas: Canvas
    
    init(canvas: Canvas) {
      self.canvas = canvas
    }
  }

  pub resource Printer {

    pub let width: UInt8
    pub let height: UInt8
    pub let prints: {String: Canvas}

    init(width: UInt8, height: UInt8) {
      self.width = width;
      self.height = height;
      self.prints = {}
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

      let pixelsArray = self.unserializeArrayString(line: canvas.pixels, width: canvas.width )

      log(topAndBottomFrame)
      for line in pixelsArray {
        log(sideFrame.concat(line).concat(sideFrame))
      }
      log(topAndBottomFrame)
    }

    pub fun print(canvas: Canvas): @Picture? {
      // Canvas needs to fit Printer's dimensions.
      if canvas.pixels.length != Int(self.width * self.height) {
        return nil
      }

      // Canvas can only use visible ASCII characters.
      for symbol in canvas.pixels.utf8 {
        if symbol < 32 || symbol > 126 {
          return nil
        }
      }

      // Printer is only allowed to print unique canvases.
      if self.prints.containsKey(canvas.pixels) == false {
        let picture <- create Picture(canvas: canvas)
        self.prints[canvas.pixels] = canvas

        self.display(canvas: picture.canvas)
        log("Printing new picture");
        return <- picture
      } else {
        return nil
      }
    }
  }

  init() {
    self.account.save(
      <- create Printer(width: 5, height: 5),
      to: /storage/ArtistPicturePrinter
    )
    self.account.link<&Printer>(
      /public/ArtistPicturePrinter,
      target: /storage/ArtistPicturePrinter
    )
  }
}