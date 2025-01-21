lib:

let
  inherit (lib)
    stringToCharacters
    drop
    concatMap
    optionals
    attrValues
    converge
    filterAttrsRecursive
    nameValuePair
    ;
  inherit (builtins)
    elemAt
    length
    foldl'
    elem
    compareVersions
    listToAttrs
    ;

in
rec {
  base16digits = rec {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
    "a" = 10;
    "b" = 11;
    "c" = 12;
    "d" = 13;
    "e" = 14;
    "f" = 15;
    A = a;
    B = b;
    C = c;
    D = d;
    E = e;
    F = f;
  };

  base64digits = stringToCharacters "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

  mod = a: b: a - (a / b) * b;

  base16tobase64 =
    s:
    let
      chars = stringToCharacters s;
      go =
        x:
        let
          get16 = n: base16digits.${elemAt x n};
          a = get16 2;
          b = (get16 1) * 16;
          c = (get16 0) * 256;
          sum =
            if length x > 2 then
              c + b + a
            else if length x == 2 then
              c + b
            else if length x == 1 then
              c
            else
              0;
          get = elemAt base64digits;
          value = get (sum / 64) + get (mod sum 64);
        in
        (if length x > 0 then value else "") + (if length x > 2 then go (drop 3 x) else "");
    in
    go chars;

  md5sri = md5: "md5-${base16tobase64 md5}==";

  filterOutEmpty = converge (filterAttrsRecursive (_: v: v != { }));

  listToAttrsBy = by: list: listToAttrs (map (x: nameValuePair x.${by} x) list);
}
