//
//  File.swift
//  
//
//  Created by Admin on 11/8/21.
//

import Foundation

/// Function calling conventions
///
/// LLVM ``Function``(s), calls and invokes can all have an optional calling convention specified for the call. The calling convention of any pair of dynamic caller/callee must match, or the behavior of the program is undefined.
public enum CallingConvention: LLVMRepresentable, Equatable, Hashable {
    public var llvm: String {
        switch self {
        case .C:
            return "ccc"
        case .Fast:
            return "fastcc"
        case .Cold:
            return "coldcc"
        case .GHC:
            return CallingConvention.Numbered(10).llvm
        case .HiPE:
            return CallingConvention.Numbered(11).llvm
        case .WebKitJS:
            return "webkit_jscc"
        case .AnyReg:
            return "anyregcc"
        case .PreserveMost:
            return "preserve_mostcc"
        case .PreserveAll:
            return "preserve_allcc"
        case .CXXFastTLS:
            return "cxx_fast_tlscc"
        case .Tail:
            return "tailcc"
        case .Swift:
            return "swiftcc"
        case .SwiftTail:
            return "swifttailcc"
        case .CFGuardCheck:
            return "cfguard_checkcc"
        case .Numbered(let int):
            return "cc \(int)"
        }
    }
    
    /// The C calling convention
    ///
    /// This calling convention (the default if no other calling convention is specified) matches the target C calling conventions. This calling convention supports varargs function calls and tolerates some mismatch in the declared prototype and implemented declaration of the function (as does normal C).
    case C
    
    /// The fast calling convention
    ///
    /// This calling convention attempts to make calls as fast as possible (e.g. by passing things in registers).
    /// This calling convention allows the target to use whatever tricks it wants to produce fast code for the target, without having to conform to an externally specified ABI (Application Binary Interface).
    /// Tail calls can only be optimized when this, the tailcc, the GHC or the HiPE convention is used.
    /// This calling convention does not support varargs and requires the prototype of all callees to exactly match the prototype of the function definition.
    case Fast
    
    /// The cold calling convention
    ///
    /// This calling convention attempts to make code in the caller as efficient as possible under the assumption that the call is not commonly executed.
    /// As such, these calls often preserve all registers so that the call does not break any live ranges in the caller side.
    /// This calling convention does not support varargs and requires the prototype of all callees to exactly match the prototype of the function definition.
    /// Furthermore the inliner doesn’t consider such function calls for inlining.
    case Cold
    
    /// The GHC convention
    ///
    /// This calling convention has been implemented specifically for use by the Glasgow Haskell Compiler (GHC).
    /// It passes everything in registers, going to extremes to achieve this by disabling callee save registers.
    /// This calling convention should not be used lightly but only for specific situations such as an alternative to the register pinning performance technique often used when implementing functional programming languages.
    /// At the moment only X86 supports this convention and it has the following limitations:
    ///  - On X86-32 only supports up to 4 bit type parameters. No floating-point types are supported.
    ///  - On X86-64 only supports up to 10 bit type parameters and 6 floating-point parameters.
    ///
    /// This calling convention supports tail call optimization but requires both the caller and callee are using it.
    case GHC
    
    /// The HiPE calling convention
    ///
    /// This calling convention has been implemented specifically for use by the High-Performance Erlang (HiPE) compiler, the native code compiler of the Ericsson’s Open Source Erlang/OTP system. It uses more registers for argument passing than the ordinary C calling convention and defines no callee-saved registers. The calling convention properly supports tail call optimization but requires that both the caller and the callee use it. It uses a register pinning mechanism, similar to GHC’s convention, for keeping frequently accessed runtime components pinned to specific hardware registers. At the moment only X86 supports this convention (both 32 and 64 bit).
    case HiPE
    
    /// WebKit's Javascript calling convention
    ///
    /// This calling convention has been implemented for WebKit FTL JIT. It passes arguments on the stack right to left (as cdecl does), and returns a value in the platform’s customary return register.
    case WebKitJS
    
    /// Dynamic calling convention for code patching
    ///
    /// This is a special convention that supports patching an arbitrary code sequence in place of a call site. This convention forces the call arguments into registers but allows them to be dynamically allocated. This can currently only be used with calls to llvm.experimental.patchpoint because only this intrinsic records the location of its arguments in a side table. See Stack maps and patch points in LLVM.
    case AnyReg
    
    /// The PreserveMost calling convention
    ///
    /// This calling convention attempts to make the code in the caller as unintrusive as possible.
    /// This convention behaves identically to the C calling convention on how arguments and return values are passed, but it uses a different set of caller/callee-saved registers.
    /// This alleviates the burden of saving and recovering a large register set before and after the call in the caller.
    /// If the arguments are passed in callee-saved registers, then they will be preserved by the callee across the call.
    /// This doesn’t apply for values returned in callee-saved registers.
    ///  - On X86-64 the callee preserves all general purpose registers, except for R11. R11 can be used as a scratch register.
    ///
    /// Floating-point registers (XMMs/YMMs) are not preserved and need to be saved by the caller.
    /// The idea behind this convention is to support calls to runtime functions that have a hot path and a cold path.
    /// The hot path is usually a small piece of code that doesn’t use many registers.
    /// The cold path might need to call out to another function and therefore only needs to preserve the caller-saved registers, which haven’t already been saved by the caller.
    /// The PreserveMost calling convention is very similar to the cold calling convention in terms of caller/callee-saved registers, but they are used for different types of function calls.
    /// `Cold` is for function calls that are rarely executed, whereas `PreserveMost` function calls are intended to be on the hot path and definitely executed a lot.
    ///  Furthermore `PreserveMost` doesn’t prevent the inliner from inlining the function call.
    ///
    /// This calling convention will be used by a future version of the ObjectiveC runtime and should therefore still be considered experimental at this time.
    /// Although this convention was created to optimize certain runtime calls to the ObjectiveC runtime, it is not limited to this runtime and might be used by other runtimes in the future too.
    /// The current implementation only supports X86-64, but the intention is to support more architectures in the future.
    case PreserveMost
    
    /// The PreserveAll calling convention
    ///
    /// This calling convention attempts to make the code in the caller even less intrusive than the PreserveMost calling convention.
    /// This calling convention also behaves identical to the C calling convention on how arguments and return values are passed, but it uses a different set of caller/callee-saved registers.
    /// This removes the burden of saving and recovering a large register set before and after the call in the caller.
    /// If the arguments are passed in callee-saved registers, then they will be preserved by the callee across the call.
    /// This doesn’t apply for values returned in callee-saved registers.
    ///  - On X86-64 the callee preserves all general purpose registers, except for R11. R11 can be used as a scratch register. Furthermore it also preserves all floating-point registers (XMMs/YMMs).
    ///
    /// The idea behind this convention is to support calls to runtime functions that don’t need to call out to any other functions.
    ///
    /// This calling convention, like the PreserveMost calling convention, will be used by a future version of the ObjectiveC runtime and should be considered experimental at this time.
    case PreserveAll
    
    /// The CXX_FAST_TLS calling convention for access functions
    ///
    /// Clang generates an access function to access C++-style TLS.
    /// The access function generally has an entry block, an exit block and an initialization block that is run at the first time.
    /// The entry and exit blocks can access a few TLS IR variables, each access will be lowered to a platform-specific sequence.
    /// This calling convention aims to minimize overhead in the caller by preserving as many registers as possible (all the registers that are preserved on the fast path, composed of the entry and exit blocks).
    /// This calling convention behaves identical to the C calling convention on how arguments and return values are passed, but it uses a different set of caller/callee-saved registers.
    /// Given that each platform has its own lowering sequence, hence its own set of preserved registers, we can’t use the existing PreserveMost.
    ///  - On X86-64 the callee preserves all general purpose registers, except for RDI and RAX.
    case CXXFastTLS
    
    /// Tail callable calling convention
    ///
    /// This calling convention ensures that calls in tail position will always be tail call optimized. This calling convention is equivalent to `Fast`, except for an addition guarantee that tail calls will be produced whenever possible. Tail calls can only be optimized when this, `Fast`, `GHC` or the `HiPE` convention is used. This calling convention does not support varargs and requires the prototype of all callees to exactly match the prototype of the function definition
    case Tail
    
    /// Swift calling convention
    ///
    ///  - On X86-64 RCX and R8 are available for additional integer returns and XMM2 and XMM3 are available for additional FP/vector returns.
    ///  - On iOS platforms, we use AAPCS-VFP calling convention.
    case Swift
    
    /// The Swift tail call convention
    ///
    /// This calling convention is like the `Swift` in most respects, but also the callee pops the argument area of the stack so that mandatory tail calls are possible as in `Tail`
    case SwiftTail
    
    /// Windows Control Flow Guard (Check mechanism) convention
    ///
    /// This calling conventsion is used for the Control Flow Guard check function, calls to which can be inserted before indirect calls to check that the call target is a valid function address.
    /// The check function has no return value, but it will trigger an OS-level error if the address is not a valid target.
    /// The set of registers preserved by the check function, and the register containing the target address are architecture-specific.
    ///  - On X86 the target address is passed in ECX.
    ///  - On Arm the target address is passed in R0.
    ///  - On AArch64 the target address is passed in X15.
    case CFGuardCheck
    
    /// Numbered calling convention
    ///
    /// Anny calling convention may be specified by number allowing target-specific calling conventions to be used. Target specific calling conventsions start at 64.
    case Numbered(Int)
}
