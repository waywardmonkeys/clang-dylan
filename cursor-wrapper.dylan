module: clang

/* In the C API to libclang, they pass around the CXCursor
 * as a struct by value. This doesn't work with Dylan's
 * C-FFI. So, what we do is to wrap the routines that use
 * CXCursor to let us store it in a buffer or use the buffer
 * as a CXCursor. This is tedious, but seems fairly safe.
 */

define c-subtype <%clang-cursor-buffer> (<c-void*>) end;

define c-function %clang-get-translation-unit-cursor
  parameter tu :: <%clang-translation-unit>;
  result index :: <%clang-cursor-buffer>;
  c-name: "dylan_clang_getTranslationUnitCursor";
end;

define c-function %dylan-clang-dispose-cursor-buffer
  parameter cursor :: <%clang-cursor-buffer>;
  c-name: "free";
end;

define class <clang-cursor> (<object>)
  slot %raw :: <%clang-cursor-buffer>, required-init-keyword: raw:;
end;

define sealed domain make(singleton(<clang-cursor>));
define sealed domain initialize(singleton(<clang-cursor>));

define method initialize(cursor :: <clang-cursor>, #key) => ()
  next-method();
  finalize-when-unreachable(cursor);
end;

define method finalize(cursor :: <clang-cursor>) => ()
  %dylan-clang-dispose-cursor-buffer(cursor.%raw);
  next-method();
end;

define method clang-get-translation-unit-cursor(tu :: <clang-translation-unit>) => (cursor :: <clang-cursor>)
  let buffer :: <%clang-cursor-buffer> = %clang-get-translation-unit-cursor(tu.%raw);
  make(<clang-cursor>, raw: buffer);
end;
