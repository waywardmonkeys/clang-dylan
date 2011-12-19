module: dylan-user

define library clang-dylan
  use dylan;
  use c-ffi;
  use io; // Testing

  export clang;
end;

define module clang
  use dylan;
  use dylan-extensions;
  use c-ffi;
  use finalization;

  use format-out; //only for testing purposes
  use streams, import: { force-output }; //only for testing purposes
  use standard-io, import: { *standard-output* }; //only for testing purposes
end;
