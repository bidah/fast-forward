# Test transactions

### Deploy contract

```
flow project deploy
```

### Create Collection Transaction

```
flow transactions send ./artist/createCollection.transaction.cdc --signer emulator-artist
```

### Print Transaction

```
flow transactions send ./artist/print.transaction.cdc \
--signer emulator-artist \
--args-json='[{"type":"UInt8", "value": "5"}, {"type":"UInt8", "value": "5"}, {"type":"String", "value":"                    *****"}]'
```

### Print Canvas List

```
flow scripts execute ./artist/displayCollection.script.cdc \
--arg String:"01cf0e2f2f715450"
```

### Bottlenecks

in printing canvas list

```
❌ Command Error: failed to submit executable script: client: rpc error: code = Unknown desc = [Error Code: 1101] cadence runtime error Execution failed:
error: mismatched types
 --> b0511226f1b30a431f703f5b056776867fe182fae0a764cbaf77043665e4acad:8:30
  |
8 |   let printerRef = getAccount(emulatorAccount).getCapability(/public/public/ArtistPicturePrinter).borrow<&Artist.Printer>()
  |                               ^^^^^^^^^^^^^^^ expected `Address`, got `String`

error: cannot find variable in this scope: `ArtistPicturePrinter`
 --> b0511226f1b30a431f703f5b056776867fe182fae0a764cbaf77043665e4acad:8:76
  |
8 |   let printerRef = getAccount(emulatorAccount).getCapability(/public/public/ArtistPicturePrinter).borrow<&Artist.Printer>()
  |                                                                             ^^^^^^^^^^^^^^^^^^^^ not found in this scope

error: value of type `&Artist.Collection?` has no member `getCanvasList`
  --> b0511226f1b30a431f703f5b056776867fe182fae0a764cbaf77043665e4acad:10:19
   |
10 |   if(collectionRef.getCanvasList().length > 0) {
   |                    ^^^^^^^^^^^^^ unknown member

error: value of type `&Artist.Collection?` has no member `getCanvasList`
  --> b0511226f1b30a431f703f5b056776867fe182fae0a764cbaf77043665e4acad:11:41
   |
11 |     let canvasCollection = collectionRef.getCanvasList()
   |                                          ^^^^^^^^^^^^^ unknown member

error: value of type `&Artist.Printer?` has no member `display`
  --> b0511226f1b30a431f703f5b056776867fe182fae0a764cbaf77043665e4acad:15:42
   |
15 |       formattedPictures.append(printerRef.display(canvas: canvas))
   |                                           ^^^^^^^ unknown member
```
