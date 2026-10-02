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
08040008: push.w     {r4, r5, r6, r7, r8, lr}
0804000c: mov        r5, r3
0804000e: lsrs       r6, r1, #3

08041604: push       {r4, r5, r6, lr}
08041606: mov        r4, r0
08041608: movs       r0, #0xc
0804160a: bl         #0x8041538
0804160e: ldrb       r3, [r4]
08041610: cbz        r3, #0x8041668
08041612: ldr        r2, [pc, #0x70]
08041614: mov        r0, r4
08041616: ldr        r1, [pc, #0x70]
08041618: add.w      ip, r2, #0x84
0804161c: cmp        r3, #0x20
0804161e: bls        #0x8041672
08041620: cmp        r3, #0x60
08041622: bls        #0x8041676
08041624: cmp        r3, #0x7a
08041626: ite        ls
08041628: subls      r3, #0x40
0804162a: subhi      r3, #0x3a
0804162c: uxtb       r3, r3
0804162e: add.w      r3, r3, r3, lsl #2
08041632: lsls       r3, r3, #1
08041634: add        r3, r1
08041636: sub.w      lr, r2, #5
0804163a: add.w      r5, r2, #0x7b
0804163e: ldrb       r4, [lr, #1]!
08041642: ldrh       r6, [r3], #2
08041646: cmp        r2, lr
08041648: eor.w      r4, r4, r6, lsl #6
0804164c: strb.w     r4, [lr]
08041650: ldrb       r4, [r5, #1]!
08041654: eor.w      r4, r4, r6, lsr #2
08041658: strb       r4, [r5]
0804165a: bne        #0x804163e
0804165c: ldrb       r3, [r0, #1]!
08041660: cbz        r3, #0x8041668
08041662: adds       r2, #6
08041664: cmp        ip, r2
08041666: bne        #0x804161c
08041668: ldr        r3, [pc, #0x20]
0804166a: mov.w      r2, #-1
0804166e: str        r2, [r3]
08041670: pop        {r4, r5, r6, pc}
08041672: movs       r3, #0
08041674: b          #0x8041634
08041676: subs       r3, #0x20
08041678: uxtb       r3, r3
0804167a: add.w      r3, r3, r3, lsl #2
0804167e: lsls       r3, r3, #1
08041680: b          #0x8041634
08041682: nop        
08041684: lsls       r4, r0, #0x1c
08041686: subs       r0, #0
08041688: cdp        p8, #0xd, c0, c0, c8, #0
0804168c: b          #0x8041030
0804168e: movs       r4, #4
08041690: bx         lr
08041692: nop        
08041694: bx         lr
08041696: nop        
08041698: bx         lr
0804169a: nop        
0804169c: movs       r0, #0
0804169e: bx         lr
080416a0: push.w     {r3, r4, r5, r6, r7, r8, sb, sl, fp, lr}
080416a4: mov        fp, r2
080416a6: mov        r8, r3
080416a8: ldrd       r2, r3, [r0, #0x18]
080416ac: strd       fp, r8, [r0, #0x18]
080416b0: cmp        r3, r8
080416b2: it         eq

080456f8: ldr        r3, [pc, #0xc]
080456fa: ldrb       r3, [r3]
080456fc: cbz        r3, #0x8045704
080456fe: mov.w      r0, #-1
08045702: bx         lr
08045704: b.w        #0x80451c8
08045708: .byte      0x8b, 0xfa
0804570a: movs       r4, #4
0804570c: ldr        r3, [pc, #0xc]
0804570e: ldrb       r3, [r3]
08045710: cbnz       r3, #0x8045716
08045712: b.w        #0x8045080
08045716: mov.w      r0, #-1
0804571a: bx         lr
0804571c: .byte      0x8b, 0xfa
0804571e: movs       r4, #4
08045720: push.w     {r4, r5, r6, r7, r8, sb, sl, fp, lr}
08045724: ldr.w      sb, [pc, #0xbc]
08045728: sub.w      sp, sp, #0x1000
0804572c: ldrb.w     r3, [sb]
08045730: sub        sp, #4
08045732: cbnz       r3, #0x8045786
08045734: ldr        r7, [pc, #0xa8]
08045736: mov        r5, r1
08045738: mov        r4, r0
0804573a: mov        r6, r2
0804573c: mov        r1, r3
0804573e: mov.w      r2, #0x1000
08045742: ands       r7, r0
08045744: mov        r0, sp
08045746: bl         #0x8048f2a
0804574a: cmp        r5, #0
0804574c: ble        #0x80457dc
0804574e: add.w      sl, r7, #0x1000
08045752: mov        r2, sp
08045754: mov.w      r1, #0x1000
08045758: mov        r0, r7
0804575a: sub.w      fp, sl, r4
0804575e: bl         #0x8044e98
08045762: sub.w      r8, r4, r7
08045766: mov        r3, r0
08045768: cmp        fp, r5
0804576a: mov        r0, r6
0804576c: add        r8, sp, r8
0804576e: it         hs
08045770: movhs      fp, r5
08045772: mov        r2, fp
08045774: cbnz       r3, #0x804578a
08045776: mov        r1, r8
08045778: bl         #0x8048ed6
0804577c: cbz        r0, #0x80457c4
0804577e: ldrb.w     r3, [sb]
08045782: mov        r0, r7
08045784: cbz        r3, #0x8045796
08045786: mov.w      r3, #-1
0804578a: mov        r0, r3
0804578c: add.w      sp, sp, #0x1000
08045790: add        sp, #4
08045792: pop.w      {r4, r5, r6, r7, r8, sb, sl, fp, pc}
08045796: bl         #0x8045160
0804579a: mov        r3, r0
0804579c: mov        r2, fp
0804579e: mov        r0, r8
080457a0: mov        r1, r6
080457a2: cmp        r3, #0
080457a4: bne        #0x804578a
080457a6: bl         #0x804907c
080457aa: ldrb.w     r3, [sb]
080457ae: mov        r0, r7
080457b0: mov        r2, sp
080457b2: mov.w      r1, #0x1000
080457b6: cmp        r3, #0
080457b8: bne        #0x8045786
080457ba: bl         #0x8045080
080457be: mov        r3, r0
080457c0: cmp        r0, #0
080457c2: bne        #0x804578a
080457c4: sub.w      r5, r5, fp
080457c8: add        r6, fp
080457ca: add        r4, fp
080457cc: cmp        r5, #0
080457ce: ble        #0x80457dc
080457d0: ldrb.w     r3, [sb]
080457d4: cmp        r3, #0
080457d6: bne        #0x8045786

08034be4: push       {r4, lr}
08034be6: ldrb.w     r2, [r0, #0x1be]
08034bea: mov        r4, r0
08034bec: movs       r1, #2
08034bee: ldr        r0, [r0]
08034bf0: eor        r2, r2, #1
08034bf4: strb.w     r2, [r4, #0x1be]
08034bf8: bl         #0x8036ed4
08034bfc: ldrb.w     r3, [r4, #0x1be]
08034c00: movs       r1, #0
08034c02: ldr        r0, [r4, #4]
08034c04: movs       r2, #0x76
08034c06: cmp        r3, r1
08034c08: pop.w      {r4, lr}
08034c0c: ite        ne
08034c0e: movne      r3, #0x7f
08034c10: moveq      r3, r1
08034c12: b.w        #0x8031f68
08034c16: nop        
08034c18: ldr        r3, [pc, #0x64]
08034c1a: ldrsb.w    ip, [r0, #0x585]
08034c1e: strh.w     r1, [r0, #0x58c]
08034c22: sub.w      r2, ip, #4
08034c26: sdiv       r3, r3, r1
08034c2a: uxtb       r2, r2
08034c2c: vmov       s15, r3
08034c30: cmp        r2, #1
08034c32: vcvt.f32.s32 s15, s15
08034c36: bls        #0x8034c62
08034c38: vmov       s14, r1
08034c3c: vrintm.f32 s15, s15
08034c40: vcvt.s32.f32 s15, s15
08034c44: vcvt.f64.s32 d6, s14
08034c48: vldr       d4, [pc, #0x2c]
08034c4c: vmov       r3, s15
08034c50: vdiv.f64   d5, d4, d6