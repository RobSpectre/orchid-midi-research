; Offline disassembly. Literal pools may decode as instructions.
; Recognized jump-table data is explicitly identified below.
0803feb0: push.w     {r4, r5, r6, r7, r8, sb, lr}
0803feb4: ldrb.w     sb, [r0, #7]
0803feb8: mov        r7, r0
0803feba: ldr        r3, [pc, #0x74]
0803febc: add.w      r4, r0, #8
0803fec0: and        r2, sb, #0xf
0803fec4: adds       r0, #0xf
0803fec6: add.w      r6, r7, #0x98
0803feca: add.w      r8, r3, r2, lsl #7
0803fece: mov        sb, r2
0803fed0: mov        r5, r8
0803fed2: ldrb       r1, [r4, #7]
0803fed4: mov        ip, r5
0803fed6: mov        r2, r4
0803fed8: ldrb       lr, [r2], #1
0803fedc: and        r3, r1, #1
0803fee0: lsrs       r1, r1, #1
0803fee2: orr.w      r3, r3, lr, lsl #1
0803fee6: cmp        r2, r0
0803fee8: strb       r3, [ip], #1
0803feec: bne        #0x803fed8
0803feee: adds       r4, #8
0803fef0: adds       r5, #7
0803fef2: add.w      r0, r2, #8
0803fef6: cmp        r6, r4
0803fef8: bne        #0x803fed2
0803fefa: ldrb.w     r3, [r7, #0x9a]
0803fefe: movs       r2, #1
0803ff00: ldrb.w     r4, [r7, #0x98]
0803ff04: and        r1, r3, #1
0803ff08: ldr        r0, [pc, #0x28]
0803ff0a: ubfx       r3, r3, #1, #1
0803ff0e: lsl.w      r2, r2, sb
0803ff12: orr.w      r1, r1, r4, lsl #1
0803ff16: strb.w     r1, [r8, #0x7e]
0803ff1a: ldrb.w     r1, [r7, #0x99]
0803ff1e: orr.w      r3, r3, r1, lsl #1
0803ff22: ldr        r1, [r0]
0803ff24: orrs       r2, r1
0803ff26: strb.w     r3, [r8, #0x7f]
0803ff2a: str        r2, [r0]
0803ff2c: pop.w      {r4, r5, r6, r7, r8, sb, pc}
0803ff30: movs       r0, r0
0803ff32: subs       r0, #0
0803ff34: b          #0x803f8d8
0803ff36: movs       r4, #4
0803ff38: push.w     {r4, r5, r6, r7, r8, sb, lr}
0803ff3c: and        r3, r1, #0xf
0803ff40: movs       r2, #0
0803ff42: ldr        r7, [pc, #0xc0]
0803ff44: mov        r6, r0
0803ff46: strb       r2, [r0, #1]
0803ff48: movs       r4, #0xf0
0803ff4a: strb       r3, [r0, #7]
0803ff4c: add.w      r7, r7, r3, lsl #7
0803ff50: movs       r2, #0x22
0803ff52: movs       r3, #1
0803ff54: movs       r1, #0xc
0803ff56: strb       r4, [r0]
0803ff58: strb       r2, [r0, #2]
0803ff5a: add.w      ip, r6, #0xf
0803ff5e: strb       r3, [r0, #4]
0803ff60: movs       r2, #0x7f
0803ff62: strb       r1, [r0, #3]
0803ff64: movs       r3, #0x7a
0803ff66: adds       r0, #8
0803ff68: rsbs       r4, r7, #0
0803ff6a: add.w      r5, r6, #0x98
0803ff6e: strb       r2, [r6, #5]
0803ff70: strb       r3, [r6, #6]
0803ff72: mvns       r2, r4
0803ff74: mov        r1, r0
0803ff76: mov.w      r8, #0
0803ff7a: add.w      lr, r4, #1
0803ff7e: add.w      sb, lr, r2
0803ff82: ldrb       r3, [r2, #1]!
0803ff86: lsrs       r3, r3, #1
0803ff88: strb       r3, [r1], #1
0803ff8c: cmp        r1, ip
0803ff8e: ldrb       r3, [r2]
0803ff90: and        r3, r3, #1
0803ff94: lsl.w      r3, r3, sb
0803ff98: orr.w      r3, r8, r3
0803ff9c: uxtb.w     r8, r3
0803ffa0: bne        #0x803ff7e
0803ffa2: adds       r0, #8
0803ffa4: add.w      ip, r1, #8
0803ffa8: subs       r4, #7
0803ffaa: strb       r8, [r0, #-0x1]
0803ffae: cmp        r0, r5
0803ffb0: bne        #0x803ff72
0803ffb2: ldrb.w     r2, [r7, #0x7f]
0803ffb6: ldrb.w     r3, [r7, #0x7e]
0803ffba: lsls       r2, r2, #1
0803ffbc: and        r0, r3, #1
0803ffc0: lsrs       r3, r3, #1
0803ffc2: and        r2, r2, #2
0803ffc6: strb.w     r3, [r6, #0x98]
0803ffca: adds       r3, r6, #1
0803ffcc: ldrb.w     r1, [r7, #0x7f]
0803ffd0: orrs       r2, r0
0803ffd2: add.w      r0, r6, #0x9b
0803ffd6: lsrs       r1, r1, #1
0803ffd8: strb.w     r2, [r6, #0x9a]
0803ffdc: movs       r2, #0
0803ffde: strb.w     r1, [r6, #0x99]
0803ffe2: ldrb       r1, [r3], #1
0803ffe6: cmp        r0, r3
0803ffe8: add        r2, r1
0803ffea: bne        #0x803ffe2
0803ffec: rsbs       r3, r2, #0
0803ffee: movs       r2, #0xf7
0803fff0: movs       r0, #0x9d
0803fff2: and        r3, r3, #0x7f
0803fff6: strb.w     r2, [r6, #0x9c]
0803fffa: strb.w     r3, [r6, #0x9b]
0803fffe: pop.w      {r4, r5, r6, r7, r8, sb, pc}
08040002: nop        
08040004: movs       r0, r0
08040006: subs       r0, #0
