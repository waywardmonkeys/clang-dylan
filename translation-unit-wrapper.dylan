module: clang

define c-subtype <%clang-translation-unit> (<c-void*>) end;

define c-function %clang-create-translation-unit-from-source-file
  parameter index :: <%clang-index>;
  parameter filename :: <c-string>;
  parameter num-clang-command-line-args :: <c-int>;
  parameter clang-command-line-args :: <c-void*>;
  parameter num-unsaved-files :: <c-int>;
  parameter unsaved-files :: <c-void*>;
  result tu :: <%clang-translation-unit>;
  c-name: "clang_createTranslationUnitFromSourceFile";
end;

define c-function %clang-dispose-translation-unit
  parameter tu :: <%clang-translation-unit>;
  c-name: "clang_disposeTranslationUnit";
end;

define class <clang-translation-unit> (<object>)
  slot %raw :: <%clang-translation-unit>;
  slot index :: <clang-index>, required-init-keyword: index:;
  required keyword: filename:;
end;

define sealed domain make(singleton(<clang-translation-unit>));
define sealed domain initialize(singleton(<clang-translation-unit>));

define method initialize(tu :: <clang-translation-unit>, #key index :: <clang-index>, filename :: <string>) => ()
  next-method();
  tu.%raw := %clang-create-translation-unit-from-source-file(index.%raw, filename, 0, null-pointer(<c-void*>), 0, null-pointer(<c-void*>));
  finalize-when-unreachable(tu);
end;

define method finalize(tu :: <clang-translation-unit>) => ()
  %clang-dispose-translation-unit(tu.%raw);
  next-method();
end;
