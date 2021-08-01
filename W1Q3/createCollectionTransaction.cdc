import Artist from 0x01

transaction {
    prepare(account: AuthAccount) {
        account.save(<- Artist.createCollection(), to: /storage/ArtistPictureCollection);
        account.link<&Artist.Collection>(/public/ArtistPictureCollection, target: /storage/ArtistPictureCollection)
    }
}