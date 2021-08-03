import Artist from "./contract.cdc"

// Return an array of formatted Pictures that exist in the account with the a specific address.
// Return nil if that account doesn't have a Picture Collection.
pub fun main(address: Address): [String]? {
  let emulatorAccount = "f8d6e0586b0a20c7"
  let collectionRef = getAccount(address).getCapability(/public/ArtistPictureCollection).borrow<&Artist.Collection>()
  let printerRef = getAccount(emulatorAccount).getCapability(/public/public/ArtistPicturePrinter).borrow<&Artist.Printer>()

  if(collectionRef.getCanvasList().length > 0) {
    let canvasCollection = collectionRef.getCanvasList()
    let formattedPictures: [String] =  []

    for canvas in canvasCollection {
      formattedPictures.append(printerRef.display(canvas: canvas))
    }

    return formattedPictures
  } 

  return nil
}