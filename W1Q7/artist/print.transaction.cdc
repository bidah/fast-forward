import Artist from "./contract.cdc"

// Print a Picture and store it in the authorizing account's Picture Collection.
transaction(width: UInt8, height: UInt8, pixels: String) {
  prepare(account: AuthAccount) {
    let printerRef = getAccount(0xf8d6e0586b0a20c7).getCapability(/public/ArtistPicturePrinter).borrow<&Artist.Printer>() ?? panic("Can't print")
    let collectionRef = account.getCapability(/public/ArtistPictureCollection).borrow<&Artist.Collection>() ?? panic("Can't find collection'")


    let canvas = Artist.Canvas(width: width, height: height, pixels: pixels)
    let collection = collectionRef
      .deposit(picture: <- printerRef.print(canvas: canvas)! )
  }
}