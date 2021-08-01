import Artist from 0x01

transaction {
  
  let pixels: String
  let picture: @Artist.Picture?
  let collectionRef: &Artist.Collection;

  prepare(account: AuthAccount) {
    let printerRef = getAccount(0x01)
      .getCapability<&Artist.Printer>(/public/ArtistPicturePrinter)
      .borrow()
      ?? panic("Couldn't borrow printer reference.")
    
    self.pixels = "*   * * *   *   * * *    ";
    let canvas = Artist.Canvas(
      width: printerRef.width,
      height: printerRef.height,
      pixels: self.pixels
    );
    self.picture <- printerRef.print(canvas: canvas);

    self.collectionRef = account
      .getCapability(/public/ArtistPictureCollection)
      .borrow<&Artist.Collection>() ?? panic("Couldn't borrow collection reference")
  }
  execute {
    if (self.picture != nil) {
        self.collectionRef.deposit(picture: <- self.picture!)
    } else {
      log("Picture not printed")
      destroy self.picture
    }
  }
}