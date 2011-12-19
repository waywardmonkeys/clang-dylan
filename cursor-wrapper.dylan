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
  parameter buffer :: <%clang-cursor-buffer>;
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

define method %dylan-clang-invoke-visit-callback
    (cursor-buffer :: <%clang-cursor-buffer>,
     parent-cursor-buffer :: <%clang-cursor-buffer>,
     data :: <c-dylan-object>)
 => ()
  let visitor = import-c-dylan-object(data);
  if (visitor)
    apply(visitor, cursor-buffer, parent-cursor-buffer);
  end;
end;

define c-callable-wrapper %invoke-visit-callback of %dylan-clang-invoke-visit-callback
  parameter cursor-buffer :: <%clang-cursor-buffer>;
  parameter parent-cursor-buffer :: <%clang-cursor-buffer>;
  parameter data :: <c-dylan-object>;
  c-name: "dylan_clang_invoke_visit_callback";
end;

define c-function %clang-visit-children
  parameter buffer :: <%clang-cursor-buffer>;
  parameter callback :: <c-function-pointer>;
  parameter data :: <c-dylan-object>;
  result xxx :: <c-unsigned-int>;
  c-name: "dylan_clang_visitChildren";
end;

define method clang-visit-children(cursor :: <clang-cursor>, visitor :: <function>)
  register-c-dylan-object(visitor);
  let visitor-handle = export-c-dylan-object(visitor);
  %clang-visit-children(cursor.%raw, %invoke-visit-callback, visitor-handle);
  unregister-c-dylan-object(visitor);
end;

