import Artist from 0x01

pub fun main(): Int {

  let accounts = [getAccount(0x01), getAccount(0x02), getAccount(0x03), getAccount(0x04)]

  for account in accounts {
    let printerRef = getAccount(0x01)
      .getCapability(/public/ArtistPicturePrinter)
      .borrow<&Artist.Printer>() ?? panic("No printer found")

    let collectionRef = account
      .getCapability(/public/ArtistPictureCollection)
      .borrow<&Artist.Collection>() ?? panic("No collection found")

      if (collectionRef.getCanvasList().length > 0) {
          for canvas in collectionRef.getCanvasList() {
            printerRef.display(canvas: canvas)
          }
      } else {
        log("Empty collection")
      }
  }

  return 0
}
