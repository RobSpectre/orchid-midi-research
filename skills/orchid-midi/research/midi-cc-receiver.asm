; Offline disassembly. Literal pools may decode as instructions.
; Recognized jump-table data is explicitly identified below.
00004c30: ldrb       r3, [r1, #1]
00004c32: ldrb.w     ip, [r1]
00004c36: cmp        r3, #0x7b
00004c38: bhi.w      #0x4d76
00004c3c: cmp        r3, #0x61
00004c3e: and        r2, ip, #0xf
00004c42: push       {r4, r5, r6, lr}
00004c44: mov        r4, r0
00004c46: bls        #0x4c88
00004c48: subs       r3, #0x62
00004c4a: cmp        r3, #0x19
00004c4c: bhi        #0x4c86
00004c4e: tbb        [pc, r3]
00004c52: .table 51 0d
00004c54: .table 1a 1a
00004c56: .table 1a 1a
00004c58: .table 1a 1a
00004c5a: .table 1a 1a
00004c5c: .table 1a 1a
00004c5e: .table 1a 1a
00004c60: .table 1a 1a
00004c62: .table 1a 1a
00004c64: .table 1a 1a
00004c66: .table 1a 1a
00004c68: .table 5e 38
00004c6a: .table 1a 4a
00004c6c: add.w      r4, r4, #0x6000
00004c70: ldr.w      r3, [r4, #0x65c]
00004c74: strb.w     r2, [r4, #0x660]
00004c78: and        r3, r3, #0x7f
00004c7c: ldrb       r2, [r1, #2]
00004c7e: orr.w      r3, r3, r2, lsl #7
00004c82: str.w      r3, [r4, #0x65c]
00004c86: pop        {r4, r5, r6, pc}
00004c88: cmp        r3, #6
00004c8a: beq        #0x4d56
00004c8c: cmp        r3, #0x40
00004c8e: beq        #0x4cac
00004c90: cmp        r3, #1
00004c92: bne        #0x4c86
00004c94: tst.w      ip, #0xe
00004c98: bne        #0x4c86
00004c9a: ldrb       r3, [r1, #2]
00004c9c: rsb        r2, r2, r2, lsl #4
00004ca0: lsls       r3, r3, #0x10
00004ca2: add.w      r2, r0, r2, lsl #5
00004ca6: str.w      r3, [r2, #0x140]
00004caa: pop        {r4, r5, r6, pc}
00004cac: tst.w      ip, #0xe
00004cb0: bne        #0x4c86
00004cb2: ldrb       r1, [r1, #2]
00004cb4: subs       r1, #0
00004cb6: pop.w      {r4, r5, r6, lr}
00004cba: it         ne
00004cbc: movne      r1, #1
00004cbe: b.w        #0x35ec
00004cc2: ands       r1, ip, #0xe
00004cc6: bne        #0x4c86
00004cc8: rsb        r3, r2, r2, lsl #4
00004ccc: movs       r5, #0
00004cce: mov        r0, r4
00004cd0: add.w      r3, r4, r3, lsl #5
00004cd4: movs       r4, #0
00004cd6: add.w      r3, r3, #0x140
00004cda: strd       r4, r5, [r3]
00004cde: pop.w      {r4, r5, r6, lr}
00004ce2: b.w        #0x35ec
00004ce6: mov        r0, r4
00004ce8: movs       r2, #3
00004cea: movs       r1, #0
00004cec: pop.w      {r4, r5, r6, lr}
00004cf0: b.w        #0x349c
00004cf4: add.w      r4, r4, #0x6000
00004cf8: ldr.w      r3, [r4, #0x65c]
00004cfc: strb.w     r2, [r4, #0x660]
00004d00: and        r3, r3, #0x3f80
00004d04: ldrb       r2, [r1, #2]
00004d06: orrs       r3, r2
00004d08: str.w      r3, [r4, #0x65c]
00004d0c: pop        {r4, r5, r6, pc}
00004d0e: movw       r1, #0x49c0
00004d12: movs       r5, #0
00004d14: mov        r3, r4
00004d16: movs       r0, #3
00004d18: add        r1, r4
00004d1a: str.w      r5, [r4, #0x150]
00004d1e: str.w      r5, [r4, #0x330]
00004d22: ldr.w      r2, [r3, #0x6e4]
00004d26: addw       r3, r3, #0x49c
00004d2a: asr.w      r2, r0, r2
00004d2e: lsls       r2, r2, #0x1f
00004d30: it         mi
00004d32: strbmi.w   r5, [r3, #0x304]
00004d36: cmp        r1, r3
00004d38: bne        #0x4d22
00004d3a: movw       r0, #0x50bc
00004d3e: movs       r1, #1
00004d40: add        r0, r4
00004d42: bl         #0x6ae8
00004d46: movw       r0, #0x573c
00004d4a: movs       r1, #1
00004d4c: add        r0, r4
00004d4e: pop.w      {r4, r5, r6, lr}
00004d52: b.w        #0x6ae8
00004d56: add.w      r4, r0, #0x6000
00004d5a: ldr.w      r5, [r4, #0x65c]
00004d5e: cmp        r5, #0x86
00004d60: bhi        #0x4c86
00004d62: ldrb.w     r2, [r4, #0x660]
00004d66: cmp        r2, #2
00004d68: bhi        #0x4c86
00004d6a: ldrb       r3, [r1, #2]
00004d6c: mov        r1, r5
00004d6e: pop.w      {r4, r5, r6, lr}
00004d72: b.w        #0x4ae8
00004d76: bx         lr
