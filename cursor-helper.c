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

