import KittyItems from  Project.KittyItems
import NonFungibleToken from Flow.NonFungibleToken
// TODO:
// Add imports here, then do steps 1 and 2.

// This script returns an array of all the NFT IDs in an account's Kitty Items Collection.

pub fun main(address: Address): [UInt64] {
  let account = getAccount(address)
  // 1) Get a public reference to the address' public Kitty Items Collection
  let kittyItemsCollectionRef = account
    .getCapability(KittyItems.CollectionPublicPath)
    .borrow<&{NonFungibleToken.CollectionPublic}>() 
    ?? panic("Couldn't borrow a public reference to the account Kitty Items Collection")

  // 2) Return the Collection's IDs 
  return kittyItemsCollectionRef.getIDs()
}