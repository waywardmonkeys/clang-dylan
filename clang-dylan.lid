library:       	clang-dylan
target-type:    executable
files:          library
                index-wrapper
                translation-unit-wrapper
                cursor-wrapper
                main
c-source-files: cursor-helper.c
c-libraries:    -lclangFrontendTool -lclangFrontend -lclangDriver -lclangSerialization -lclangCodeGen -lclangParse -lclangSema -lclangStaticAnalyzerFrontend -lclangStaticAnalyzerCheckers -lclangStaticAnalyzerCore -lclangAnalysis -lclangIndex -lclangARCMigrate -lclangRewrite -lclangAST -lclangLex -lclangBasic -lclang -lLLVMAsmParser -lLLVMInstrumentation -lLLVMLinker -lLLVMArchive -lLLVMBitReader -lLLVMDebugInfo -lLLVMJIT -lLLVMipo -lLLVMBitWriter -lLLVMTableGen -lLLVMHexagonCodeGen -lLLVMHexagonDesc -lLLVMHexagonInfo -lLLVMPTXCodeGen -lLLVMPTXDesc -lLLVMPTXAsmPrinter -lLLVMPTXInfo -lLLVMMBlazeCodeGen -lLLVMMBlazeDisassembler -lLLVMMBlazeDesc -lLLVMMBlazeAsmPrinter -lLLVMMBlazeAsmParser -lLLVMMBlazeInfo -lLLVMCppBackendCodeGen -lLLVMCppBackendInfo -lLLVMCBackendCodeGen -lLLVMCBackendInfo -lLLVMMSP430CodeGen -lLLVMMSP430Desc -lLLVMMSP430Info -lLLVMMSP430AsmPrinter -lLLVMXCoreCodeGen -lLLVMXCoreDesc -lLLVMXCoreInfo -lLLVMCellSPUCodeGen -lLLVMCellSPUDesc -lLLVMCellSPUInfo -lLLVMMipsCodeGen -lLLVMMipsDesc -lLLVMMipsInfo -lLLVMMipsAsmPrinter -lLLVMARMDisassembler -lLLVMARMAsmParser -lLLVMARMCodeGen -lLLVMARMDesc -lLLVMARMInfo -lLLVMARMAsmPrinter -lLLVMPowerPCCodeGen -lLLVMPowerPCDesc -lLLVMPowerPCAsmPrinter -lLLVMPowerPCInfo -lLLVMSparcCodeGen -lLLVMSparcDesc -lLLVMSparcInfo -lLLVMX86Disassembler -lLLVMX86AsmParser -lLLVMX86CodeGen -lLLVMSelectionDAG -lLLVMAsmPrinter -lLLVMX86Desc -lLLVMX86Info -lLLVMX86AsmPrinter -lLLVMX86Utils -lLLVMMCDisassembler -lLLVMMCParser -lLLVMInterpreter -lLLVMCodeGen -lLLVMScalarOpts -lLLVMInstCombine -lLLVMTransformUtils -lLLVMipa -lLLVMAnalysis -lgtest_main -lgtest -lLLVMMCJIT -lLLVMRuntimeDyld -lLLVMExecutionEngine -lLLVMTarget -lLLVMMC -lLLVMObject -lLLVMCore -lLLVMSupport -lstdc++
jam-includes:   clang.jam
