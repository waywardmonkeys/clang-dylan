module: clang

begin
  let index = make(<clang-index>);
  let tu = make(<clang-translation-unit>, index: index, filename: "test.h");
  let cursor = clang-get-translation-unit-cursor(tu);
  format-out("Hello world\n");
  force-output(*standard-output*);
end;
