#include "clang-c/Index.h"

#include <stdlib.h>
#include <string.h>

void* dylan_clang_getTranslationUnitCursor(CXTranslationUnit tu)
{
  CXCursor cursor = clang_getTranslationUnitCursor(tu);
  void* buffer = malloc(sizeof(cursor));
  memcpy(buffer, &cursor, sizeof(cursor));
  return buffer;
}

unsigned dylan_clang_visitChildren(void* cursorBuffer,
                                   CXCursorVisitor visitor,
                                   CXClientData client_data)
{
  CXCursor cursor = *(CXCursor *)cursorBuffer;
  return clang_visitChildren(cursor, visitor, client_data);
}

enum CXChildVisitResult dylan_clang_cursor_visitor(CXCursor cursor,
                                                   CXCursor parent,
                                                   CXClientData client_data)
{
  dylan_clang_invoke_visit_callback(&cursor, &parent, client_data);
  return CXChildVisit_Continue;
}

