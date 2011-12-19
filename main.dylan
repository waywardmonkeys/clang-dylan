module: clang

begin
  let index = make(<clang-index>);
  let tu = make(<clang-translation-unit>, index: index, filename: "test.h");
  let cursor = clang-get-translation-unit-cursor(tu);
  let visitor = method(#rest fs)
      format-out("Visiting %=", fs);
    end;
  clang-visit-children(cursor, visitor);

  // Make sure any pending output is flushed.
  force-output(*standard-output*);
end;
