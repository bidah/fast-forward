import Artist from "./contract.cdc"

// Create a Picture Collection for the transaction authorizer.

transaction {
    prepare(account: AuthAccount) {
        account.save(<- Artist.createCollection(), to: /storage/ArtistPictureCollection);
        account.link<&Artist.Collection>(/public/ArtistPictureCollection, target: /storage/ArtistPictureCollection)
    }
}