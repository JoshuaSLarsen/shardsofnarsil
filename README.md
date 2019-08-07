# shardsofnarsil

testing ssss

## Getting Started

#### Home.dart
* Line 18 put in a string code, then it is encoded into bytes, using dart:convert
* Line 21 it generates shards, and puts them into state.
* Line 13 defines the SSS scheme, the first argument is how many pieces up to 255,(uses GF(256)) the second argument is how many pieces are needed to reforge the key
* the bottom right button on the app will run the function secret() which will do all of the above and print to terminal
* the button on the top will take in the variable some shares, which is an key value pair array that contains the minimum set up in line 13. if the minimum is met it is printed to terminal and decoded back into a string.
