module: clang

define c-subtype <%clang-index> (<c-void*>) end;

define c-function %clang-create-index
  parameter exclude-declarations-from-pch :: <c-int>;
  parameter display-diagnostics :: <c-int>;
  result index :: <%clang-index>;
  c-name: "clang_createIndex";
end;

define c-function %clang-dispose-index
  parameter index :: <%clang-index>;
  c-name: "clang_disposeIndex";
end;

define class <clang-index> (<object>)
  slot %raw :: <%clang-index>;
end;

define sealed domain make(singleton(<clang-index>));
define sealed domain initialize(singleton(<clang-index>));

define method initialize(index :: <clang-index>, #key exclude-declarations-from-pch :: <boolean> = #f, display-diagnostics :: <boolean> = #f) => ()
  next-method();
  let edfp = if (exclude-declarations-from-pch) 1 else 0 end;
  let dd = if (display-diagnostics) 1 else 0 end;
  index.%raw := %clang-create-index(edfp, dd);
  finalize-when-unreachable(index);
end;

define method finalize(index :: <clang-index>) => ()
  %clang-dispose-index(index.%raw);
  next-method();
end;
