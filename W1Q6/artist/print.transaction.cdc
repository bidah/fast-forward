import Artist from "./contract.cdc"

// Print a Picture and store it in the authorizing account's Picture Collection.
transaction(width: UInt8, height: UInt8, pixels: String) {
  prepare(account: AuthAccount) {
    let printerRef = getAccount(0x01).getCapability(/public/ArtistPicturePrinter).borrow<&Artist.Printer>() ?? panic("Can't print")
    let collectionRef = account.getCapability(/public/ArtistPictureCollection).borrow<&Artist.PictureCollection>() ?? panic("Can't find collection'")

    let pixelsX = [
      "*   *",
      " * * ",
      "  *  ",
      " * * ",
      "*   *"
    ]

    let canvas = Artist.Canvas(width: 5, height: 5, pixels: Artist.Printer.serializeStringArray(pixelsX))
    let picture = printerRef.print(canvas: canvas) 
    let collection = collectionRef.deposit(picture: picture)
  }
}