; Offline disassembly. Literal pools may decode as instructions.
; Recognized jump-table data is explicitly identified below.
08045c00: push       {r3, r4, r5, lr}
08045c02: bl         #0x802f108
08045c06: cbz        r0, #0x8045c52
08045c08: mov        r1, r0
08045c0a: ldrb       r3, [r1], #1
08045c0e: and        r3, r3, #0xf
08045c12: subs       r3, #4
08045c14: cmp        r3, #0xb
08045c16: bhi        #0x8045c02
08045c18: tbb        [pc, r3]
08045c1c: .table 28 24
08045c1e: .table 20 06
08045c20: .table 1c 1c
08045c22: .table 1c 1c
08045c24: .table 1c 1c
08045c26: .table 1c 42
08045c28: ldr        r5, [pc, #0xa0]
08045c2a: adds       r1, r0, #2
08045c2c: ldrb       r2, [r0, #1]
08045c2e: ldrb       r3, [r5]
08045c30: ldr        r4, [pc, #0x9c]
08045c32: strb       r2, [r4, r3]
08045c34: adds       r3, #1
08045c36: uxtb       r3, r3
08045c38: strb       r3, [r5]
08045c3a: ldrb       r2, [r1], #1
08045c3e: strb       r2, [r4, r3]
08045c40: adds       r3, #1
08045c42: uxtb       r3, r3
08045c44: strb       r3, [r5]
08045c46: adds       r2, r3, #1
08045c48: ldrb       r1, [r1]
08045c4a: uxtb       r2, r2
08045c4c: strb       r1, [r4, r3]
08045c4e: mov        r0, r2
08045c50: strb       r2, [r5]
08045c52: pop        {r3, r4, r5, pc}
08045c54: ldr        r0, [pc, #0x7c]
08045c56: bl         #0x80490b8
08045c5a: b          #0x8045c02
08045c5c: ldr        r5, [pc, #0x6c]
08045c5e: ldr        r4, [pc, #0x70]
08045c60: ldrb       r3, [r5]
08045c62: b          #0x8045c3a
08045c64: ldr        r5, [pc, #0x64]
08045c66: ldr        r4, [pc, #0x68]
08045c68: ldrb       r3, [r5]
08045c6a: b          #0x8045c46
08045c6c: ldrb       r2, [r0, #1]
08045c6e: movs       r5, #0
08045c70: ldr        r4, [pc, #0x5c]
08045c72: cmp        r2, #0xf0
08045c74: ldr        r1, [pc, #0x54]
08045c76: beq        #0x8045cb4
08045c78: ldrb       r3, [r1]
08045c7a: cbz        r3, #0x8045cc6
08045c7c: strb       r2, [r4, r3]
08045c7e: adds       r2, r3, #1
08045c80: ldrb.w     ip, [r0, #2]
08045c84: uxtb       r2, r2
08045c86: strb.w     ip, [r4, r2]
08045c8a: adds       r2, r3, #3
08045c8c: adds       r3, #2
08045c8e: ldrb       r0, [r0, #3]
08045c90: uxtb       r2, r2
08045c92: uxtb       r3, r3
08045c94: cmp        r2, #0xfb
08045c96: strb       r2, [r1]
08045c98: strb       r0, [r4, r3]
08045c9a: bls        #0x8045c02
08045c9c: strb       r5, [r1]
08045c9e: b          #0x8045c02
08045ca0: ldr        r2, [pc, #0x28]
08045ca2: ldr        r4, [pc, #0x2c]
08045ca4: ldrb       r3, [r2]
08045ca6: adds       r1, r3, #1
08045ca8: cmp        r3, #0
08045caa: beq        #0x8045c02
08045cac: strb       r1, [r2]
08045cae: ldrb       r2, [r0, #1]
08045cb0: strb       r2, [r4, r3]
08045cb2: b          #0x8045c02
08045cb4: mov        r3, r1
08045cb6: ldrb       r1, [r0, #2]
08045cb8: strb       r2, [r4]
08045cba: movs       r2, #3
08045cbc: strb       r1, [r4, #1]
08045cbe: ldrb       r1, [r0, #3]
08045cc0: strb       r2, [r3]
08045cc2: strb       r1, [r4, #2]
08045cc4: b          #0x8045c02
08045cc6: mov        r0, r3
08045cc8: pop        {r3, r4, r5, pc}
08045cca: nop        
08045ccc: mla        r4, r0, r4, r2
08045cd0: mla        r4, r4, r4, r2
08045cd4: movs       r0, r0
08045cd6: movs       r0, #0
